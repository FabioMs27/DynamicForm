//
//  FormViewModel.swift
//  Bankaks-Assessment
//
//  Created by Fábio Maciel de Sousa on 30/11/20.
//

import Foundation

class FormViewModel{
    let option: Int
    
    init(option: Int) {
        self.option = option
    }
    
    func fetchForm(completion: @escaping (Result<Form, NetworkError>) -> Void){
        let url = URL(string: "https://api-staging.bankaks.com/task/\(option)")
        let apiRequest = Resource<Form>(path: url)
        
        apiRequest.request { result in
            switch result{
            case .success(let form):
                completion(.success(form))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
