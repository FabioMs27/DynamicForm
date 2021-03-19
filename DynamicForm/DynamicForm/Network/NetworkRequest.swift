//
//  NetworkManager.swift
//  Bankaks-Assessment
//
//  Created by Fábio Maciel de Sousa on 30/11/20.
//

import Foundation

protocol NetworkRequest: class {
    var session: URLSessionProtocol { get }
    func request<ModelType: Decodable>(urlPath: String, modelType: ModelType.Type, completionHandler: @escaping (Result<ModelType, NetworkError>) -> Void)
    func decode<ModelType: Decodable>(_ data: Data) -> ModelType?
}

extension NetworkRequest {
    func request<ModelType: Decodable>(
        urlPath: String,
        modelType: ModelType.Type,
        completionHandler: @escaping (Result<ModelType, NetworkError>) -> Void) {
        guard let url = URL(string: urlPath) else {
            completionHandler(.failure(NetworkError.invalidURL))
            return
        }
        session.dataTaskWith(url: url) { [weak self] data, response, error in
            guard error == nil else {
                completionHandler(.failure(.connectionError))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completionHandler(.failure(.invalidResponseType))
                return
            }
            guard let data = data,
                  let object: ModelType = self?.decode(data) else {
                completionHandler(.failure(.objectNotDecoded))
                return
            }
            completionHandler(.success(object))
        }.resume()
    }
}

class APIRequest: NetworkRequest {
    var session: URLSessionProtocol
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func decode<ModelType: Decodable>(_ data: Data) -> ModelType? {
        let decoder = JSONDecoder()
        let wrapper = try? decoder.decode(Wrapper<ModelType>.self, from: data)
        return wrapper?.result
    }
}
