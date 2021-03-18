//
//  NetworkManager.swift
//  Bankaks-Assessment
//
//  Created by Fábio Maciel de Sousa on 30/11/20.
//

import Foundation

protocol NetworkRequest: class {
    var session: URLSession { get }
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
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }
            self.session.dataTask(with: url) { data, response, error in
                DispatchQueue.main.async {
                    guard error == nil else {
                        completionHandler(.failure(.connectionError))
                        return
                    }
                    guard response == nil else {
                        completionHandler(.failure(.invalidResponseType))
                        return
                    }
                    guard let data = data,
                          let object: ModelType = self.decode(data) else {
                        completionHandler(.failure(.objectNotDecoded))
                        return
                    }
                    completionHandler(.success(object))
                }
            }.resume()
        }
    }
}

class APIRequest: NetworkRequest {
    var session: URLSession
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func decode<ModelType: Decodable>(_ data: Data) -> ModelType? {
        let decoder = JSONDecoder()
        let wrapper = try? decoder.decode(Wrapper<ModelType>.self, from: data)
        return wrapper?.result
    }
}
