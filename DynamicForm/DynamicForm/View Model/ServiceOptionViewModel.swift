//
//  ServiceOptionViewModel.swift
//  Bankaks-Assessment
//
//  Created by Fábio Maciel de Sousa on 30/11/20.
//

import Foundation

/// Layer related to the validation and fetch part of the serviceOption feature.
class ServiceOptionViewModel {
    /// Method that validates the inputs from the viewController and returns either the option choosen or en error.
    /// - Parameter value: A value from the textField with containing the service option.
    /// - Throws: An error describing why the value is invalid.
    /// - Returns: The number related to the option choosen.
    func inputValidator(value: String?) throws -> Int {
        guard let value = value else { throw ValidationError.pickerInputIsEmpty }
        if value.isEmpty { throw ValidationError.pickerInputIsEmpty }
        guard let option = Int(value) else { throw ValidationError.unexpectedOption }
        return option
    }
}
