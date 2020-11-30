//
//  NetworkManager.swift
//  Bankaks-Assessment
//
//  Created by Fábio Maciel de Sousa on 30/11/20.
//

import Foundation

struct Resource<T: Decodable>{
    let path: URL?
    let key: String?
    let header: String?
    
    init(path: URL?, key: String? = nil, header: String? = nil) {
        self.path = path
        self.key = key
        self.header = header
    }
}

extension Resource{
    func request(completion: @escaping (T) -> ()){
        DispatchQueue.global(qos: .background).async{
            guard let unrappedUrl = self.path else { return }
            var request = URLRequest(url: unrappedUrl)
            if let keyValue = self.key, let headerValue = self.header{
                request.addValue(keyValue, forHTTPHeaderField: headerValue)
            }
            request.httpMethod = "GET"
            URLSession.shared.dataTask(with: request){ (data,response,err) in
                guard let data = data else { return }
                do {
                    let parsedData = try JSONDecoder().decode(T.self, from: data)
                    DispatchQueue.main.async {
                        completion(parsedData)
                    }
                } catch  {
                    print(error.localizedDescription)
                }
            }.resume()
        }
    }
}
