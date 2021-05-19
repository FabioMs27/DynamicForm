//
//  Wrapper+Decodable.swift
//  DynamicForm
//
//  Created by Fábio Maciel de Sousa on 17/05/21.
//

import Foundation

extension Fields: Decodable {
    enum CodingKeys: String, CodingKey {
        case name
        case placeholder
        case regex
        case isMandatory = "is_mandatory"
        case hintText    = "hint_text"
        case type
        case uiType      = "ui_type"
        
        enum DataTypeKeys: String, CodingKey {
            case dataType = "data_type"
        }
        
        enum UITypeKeys: String, CodingKey {
            case type
            case values
            
            enum ValuesKeys: String, CodingKey {
                case name
            }
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        placeholder = try container.decode(String.self, forKey: .placeholder)
        regex = try container.decode(String.self, forKey: .regex)
        let isMandatoryString = try container.decode(String.self, forKey: .isMandatory)
        isMandatory = (isMandatoryString as NSString).boolValue
        hintText = try container.decode(String.self, forKey: .hintText)
        
        let dataTypeContainer = try container.nestedContainer(keyedBy: CodingKeys.DataTypeKeys.self, forKey: .type)
        let typeString = try dataTypeContainer.decode(String.self, forKey: .dataType)
        dataType = DataType(rawValue: typeString) ?? .none
        
        let uiTypeContainer = try container.nestedContainer(keyedBy: CodingKeys.UITypeKeys.self, forKey: .uiType)
        let uiType = try uiTypeContainer.decode(String.self, forKey: .type)
        type = UIType(rawValue: uiType) ?? .none
        var valuesContainer = try uiTypeContainer.nestedUnkeyedContainer(forKey: .values)
        var decodedValues = [String]()
        while !valuesContainer.isAtEnd {
            let valueContainer = try valuesContainer.nestedContainer(keyedBy: CodingKeys.UITypeKeys.ValuesKeys.self)
            let value = try valueContainer.decode(String.self, forKey: .name)
            decodedValues.append(value)
        }
        values = decodedValues
    }
}

struct Wrapper<T: Decodable> {
    let result: T
}

extension Wrapper: Decodable {
    enum CodingKeys: String, CodingKey {
        case result
    }
}
