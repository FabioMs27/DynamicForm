//
//  FormViewModel.swift
//  Bankaks-Assessment
//
//  Created by Fábio Maciel de Sousa on 30/11/20.
//

import Foundation

/// Layer related to the validation and fetch part of the form feature.
class FormViewModel {
    private(set) var formPublisher = Observable<Form>()
    private(set) var errorPublisher = Observable<Error>()
    private let option: Int
    private var networkRequest: AnyObject?
    
    init(option: Int) {
        self.option = option
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
        let resource = FormResource(option: option)
        let request = APIRequest(resource: resource)
        networkRequest = request
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }
            request.request { [weak self] result in
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
private extension NSRegularExpression {
    /// Method that checks if a string value matches with the regex.
    /// - Parameter string: The string value which will be checked
    /// - Returns: A boolean containing it's validation.
    func matches(_ string: String) -> Bool {
        let range = NSRange(location: 0, length: string.utf16.count)
        return firstMatch(in: string, options: [], range: range) != nil
    }
}
