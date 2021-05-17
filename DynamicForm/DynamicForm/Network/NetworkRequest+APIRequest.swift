//
//  NetworkManager.swift
//  Bankaks-Assessment
//
//  Created by Fábio Maciel de Sousa on 30/11/20.
//

import Foundation
import UIKit

protocol NetworkRequest: class {
    associatedtype ModelType
    var session: URLSessionProtocol { get }
    func request(urlPath: String, completionHandler: @escaping (Result<ModelType, NetworkError>) -> Void)
    func decode(_ data: Data) -> ModelType?
}

extension NetworkRequest {
    internal func request(
        urlPath: String,
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

class APIRequest<Resource: APIResource>: NetworkRequest {
    var session: URLSessionProtocol
    let resource: Resource
    
    init(session: URLSessionProtocol = URLSession.shared, resource: Resource) {
        self.session = session
        self.resource = resource
    }
    
    func request(completionHandler: @escaping (Result<Resource.ModelType, NetworkError>) -> Void) {
        self.request(urlPath: resource.urlPath, completionHandler: completionHandler)
    }
    
    func decode(_ data: Data) -> Resource.ModelType? {
        let decoder = JSONDecoder()
        let wrapper = try? decoder.decode(Wrapper<Resource.ModelType>.self, from: data)
        return wrapper?.result
    }
}
