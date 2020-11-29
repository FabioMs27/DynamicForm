//
//  ViewController.swift
//  Bankaks-Assessment
//
//  Created by Fábio Maciel de Sousa on 29/11/20.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchFormType(option: 3)
    }
    
    func fetchFormType(option: Int){
        DispatchQueue.global(qos: .background).async{
            guard let url = URL(string: "https://api-staging.bankaks.com/task/\(option)") else { return }
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            URLSession.shared.dataTask(with: request){ (data,response,err) in
                if let data = data{
                    let result = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                    print(result as Any)
                }
            }.resume()
        }
    }
}
