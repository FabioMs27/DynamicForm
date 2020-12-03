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
    
    func isMandatoryValidator(value: String?, pattern: String, isMandatory: Bool) throws {
        let value = value ?? ""
        if value.isEmpty, isMandatory { throw ValidationError.inputIsEmpty }
        if pattern.isEmpty { return }
//        guard let regex = try? NSRegularExpression(pattern: pattern) else { throw ValidationError.invalidInput }
//        let isValid = regex.matches(value)
//        if !isValid { throw ValidationError.invalidInput }
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

extension NSRegularExpression {
    func matches(_ string: String) -> Bool {
        let range = NSRange(location: 0, length: string.utf16.count)
        return firstMatch(in: string, options: [], range: range) != nil
    }
}
