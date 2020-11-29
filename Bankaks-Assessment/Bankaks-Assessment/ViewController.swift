//
//  ViewController.swift
//  Bankaks-Assessment
//
//  Created by Fábio Maciel de Sousa on 29/11/20.
//

import UIKit

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

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchFormType(option: 3)
    }
    
    func fetchFormType(option: Int){
        let url = URL(string: "https://api-staging.bankaks.com/task/\(option)")
        let bankaksApi = Resource<Form>(path: url)
        bankaksApi.requestApi { (form) in
            print(form)
        }
    }
}

//Request API
extension Resource{
    //Method to consume API
    func requestApi(completion: @escaping (T) -> ()){
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
