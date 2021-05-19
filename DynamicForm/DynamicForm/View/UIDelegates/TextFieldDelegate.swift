
//
//  TextFieldDelegate.swift
//  DynamicForm
//
//  Created by Fábio Maciel de Sousa on 24/03/21.
//

import UIKit

class ReturnTextFieldDelegate: NSObject, UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

class NumberTextFieldDelegate: ReturnTextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
}

class OptionTextFieldDelegate: ReturnTextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
}
