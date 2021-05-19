//
//  Form.swift
//  Bankaks-Assessment
//
//  Created by Fábio Maciel de Sousa on 29/11/20.
//

import UIKit

enum DataType: String {
    private static let numberDelegate = NumberTextFieldDelegate()
    private static let returnDelegate = ReturnTextFieldDelegate()
    
    case int
    case string
    case none
    
    func getTextFieldDelegate() -> UITextFieldDelegate? {
        switch self {
        case .int:    return Self.numberDelegate
        case .string: return Self.returnDelegate
        default:      return nil
        }
    }
    
    func getKeyboardType() -> UIKeyboardType {
        switch self {
        case .int: return .numberPad
        default:   return .default
        }
    }
}

enum UIType: String {
    case dropdown
    case textfield
    case none
}

struct Form {
    let screenTitle: String
    let fields: [Fields]
}

extension Form: Decodable {
    enum CodingKeys: String, CodingKey {
        case screenTitle = "screen_title"
        case fields
    }
}

struct Fields {
    let name: String
    let placeholder: String
    let regex: String
    let dataType: DataType
    let isMandatory: Bool
    let hintText: String
    let type: UIType
    let values: [String]
}
