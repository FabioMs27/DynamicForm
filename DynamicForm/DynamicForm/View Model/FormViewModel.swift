//
//  FormViewModel.swift
//  Bankaks-Assessment
//
//  Created by Fábio Maciel de Sousa on 30/11/20.
//

import Foundation

/// Layer related to the validation and fetch part of the form feature.
class FormViewModel{
    var formPublisher = Observer<Form>()
    var errorPublisher = Observer<Error>()
    let option: Int
    private let networkRequest: NetworkRequest
    
    init(option: Int, networkRequest: NetworkRequest = APIRequest()) {
        self.option = option
        self.networkRequest = networkRequest
    }
    
    /// Method that validates each form field and returns an error in calse it's invalid.
    /// - Parameters:
    ///   - value: A string containing the value retrieved from the textField.
    ///   - pattern: The regex related pattern.
    ///   - isMandatory: A boolean checking if a textField is mandatory.
    /// - Throws: An error discription to why the validation failed.
    func validateInputs(value: String?, pattern: String) throws {
        let value = value ?? ""
        if value.isEmpty { throw ValidationError.inputIsEmpty }
        if pattern.isEmpty { return }
        guard let regex = try? NSRegularExpression(pattern: pattern) else {
            throw ValidationError.invalidInput
        }
        if !regex.matches(value) { throw ValidationError.invalidInput }
    }
    
    /// Method which calls the api and return a completion containing either the model or an error.
    /// - Parameter completion: A closure containing either the method or an error.
    func fetchForm() {
        let urlPath = "https://api-staging.bankaks.com/task/\(option)"
        DispatchQueue.global(qos: .background).async { [weak self] in
            self?.networkRequest.request(urlPath: urlPath, modelType: Form.self) { result in
                DispatchQueue.main.async {
                    switch result{
                    case .success(let form):
                        self?.formPublisher.value = form
                    case .failure(let error):
                        self?.errorPublisher.value = error
                    }
                }
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
