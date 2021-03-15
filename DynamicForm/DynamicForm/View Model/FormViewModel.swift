//
//  FormViewModel.swift
//  Bankaks-Assessment
//
//  Created by Fábio Maciel de Sousa on 30/11/20.
//

import Foundation

/// Layer related to the validation and fetch part of the form feature.
class FormViewModel{
    //MARK:- Atributtes
    let option: Int
    //MARK:- Constructor
    init(option: Int) {
        self.option = option
    }
    //MARK:- Methods
    /// Method that validates each form field and returns an error in calse it's invalid.
    /// - Parameters:
    ///   - value: A string containing the value retrieved from the textField.
    ///   - pattern: The regex related pattern.
    ///   - isMandatory: A boolean checking if a textField is mandatory.
    /// - Throws: An error discription to why the validation failed.
    func isMandatoryValidator(value: String?, pattern: String, isMandatory: Bool) throws {
        let value = value ?? ""
        if value.isEmpty, isMandatory { throw ValidationError.inputIsEmpty }
        if pattern.isEmpty { return }
        guard let regex = try? NSRegularExpression(pattern: pattern) else {
            throw ValidationError.invalidInput
        }
        if !regex.matches(value) { throw ValidationError.invalidInput }
    }
    
    /// Method which calls the api and return a completion containing either the model or an error.
    /// - Parameter completion: A closure containing either the method or an error.
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
//MARK:- NSRegularExpression
extension NSRegularExpression {
    /// Method that checks if a string value matches with the regex.
    /// - Parameter string: The string value which will be checked
    /// - Returns: A boolean containing it's validation.
    func matches(_ string: String) -> Bool {
        let range = NSRange(location: 0, length: string.utf16.count)
        return firstMatch(in: string, options: [], range: range) != nil
    }
}
