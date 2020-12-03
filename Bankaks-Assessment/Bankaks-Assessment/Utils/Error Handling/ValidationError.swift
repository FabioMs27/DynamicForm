//
//  ValidationError.swift
//  Bankaks-Assessment
//
//  Created by Fábio Maciel de Sousa on 01/12/20.
//

import Foundation

enum ValidationError: Error {
    case pickerInputIsEmpty
    case unexpectedOption
    case inputIsEmpty
    case invalidInput
}

extension ValidationError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .pickerInputIsEmpty: return "Option must be selected to procced"
        case .unexpectedOption: return "This option is invalid"
        case .inputIsEmpty: return "* This field is mandatory"
        case .invalidInput: return "This input is invalid"
        }
    }
}
