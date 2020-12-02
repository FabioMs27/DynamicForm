//
//  ValidationError.swift
//  Bankaks-Assessment
//
//  Created by Fábio Maciel de Sousa on 01/12/20.
//

import Foundation

enum ValidationError: Error {
//    case inputIsNil,
//         inputIsEmpty,
//         inputIsNotDouble,
//         valueIsNegative,
//         unselectedSourceCurrency,
//         unselectedDestinyCurrency
    case pickerInputIsEmpty
    case unexpectedOption
}

extension ValidationError: LocalizedError {
//    var errorDescription: String? {
//        switch self {
//        case .inputIsNil: return "Valor não pode ser nulo"
//        case .inputIsEmpty: return "Valor não pode ser vazio"
//        case .inputIsNotDouble: return "Valor inserido é inválido"
//        case .valueIsNegative: return "Valor não pode ser negativo"
//        case .unselectedSourceCurrency: return "Moeda origem não escolhida"
//        case .unselectedDestinyCurrency: return "Moeda destino não escolhida"
//        }
//    }
    var errorDescription: String? {
        switch self {
        case .pickerInputIsEmpty: return "Option must be selected to procced"
        case .unexpectedOption:   return "This option is invalid"
        }
    }
}
