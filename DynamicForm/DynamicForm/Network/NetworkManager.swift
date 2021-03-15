//
//  NetworkManager.swift
//  Bankaks-Assessment
//
//  Created by Fábio Maciel de Sousa on 30/11/20.
//

import Foundation

/// Network manager atributes. It contains the url path and the keys required to fetch from it.
struct Resource<T: Decodable> {
    let path: URL?
    let key: String?
    let header: String?
    
    init(path: URL?, key: String? = nil, header: String? = nil) {
        self.path = path
        self.key = key
        self.header = header
    }
}

extension Resource {
    /// Method that request to the api and returns either a model or error.
    /// - Parameter completion: Closure containing either the model after parsing or an error based on the request.
    /// - Returns: Void
    func request(completion: @escaping (Result<T, NetworkError>) -> ()){
        DispatchQueue.global(qos: .background).async{
            guard let url = self.path else {
                completion(.failure(.invalidURL))
                return
            }
            
            var request = URLRequest(url: url)
            if let keyValue = self.key, let headerValue = self.header{
                request.addValue(keyValue, forHTTPHeaderField: headerValue)
            }
            request.httpMethod = "GET"
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                guard error == nil else {
                    var networkError: NetworkError = .unknownError
                    if error!.localizedDescription.uppercased().contains("OFFLINE") {
                        networkError = .offline
                    }
                    completion(.failure(networkError))
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    completion(.failure(.connectionError))
                    return
                }
                
                guard let mime = response?.mimeType, mime == "application/json" else {
                    completion(.failure(.invalidResponseType))
                    return
                }
                
                guard
                    let data = data,
                    let object: T = self.decode(data: data) else {
                    DispatchQueue.main.async {
                        completion(.failure(.objectNotDecoded))
                    }
                    return
                }
                
                completion(.success(object))
            }.resume()
        }
    }
    
    /// Method that parse data and returns a model.
    /// - Parameter data: Data recieved from the api request.
    /// - Returns: A generic model that conforms to Decodable.
    private func decode<T: Decodable>(data: Data) -> T? {
        let decoder = JSONDecoder()
        
        let object = try? decoder.decode(T.self, from: data)
        
        return object
    }
}
