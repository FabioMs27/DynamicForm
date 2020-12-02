//
//  ServiceOptionViewModel.swift
//  Bankaks-Assessment
//
//  Created by Fábio Maciel de Sousa on 30/11/20.
//

import Foundation

class ServiceOptionViewModel{
    func inputValidator(value: String?) throws -> Int{
        guard let value = value else { throw ValidationError.pickerInputIsEmpty }
        if value.isEmpty { throw ValidationError.pickerInputIsEmpty }
        guard let option = Int(value) else { throw ValidationError.unexpectedOption }
        return option
    }
}
