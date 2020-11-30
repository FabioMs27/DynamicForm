//
//  Form.swift
//  Bankaks-Assessment
//
//  Created by Fábio Maciel de Sousa on 29/11/20.
//

import Foundation

struct Form: Codable{
    let status: String
    let message: String
    let result: Result
}

struct Result: Codable{
    let number_of_fields: Int
    let screen_title: String
    let operator_name: String
    let service_id: String
    let fields: [Field]
}

struct Field: Codable{
    let name: String
    let placeholder: String
    let regex: String
    let type: Type
    let ui_type: UIType
}

struct Type : Codable{
    let data_type: String
    let is_array: Bool
    let array_name: String
    let is_mandatory: Bool
    let hint_text: String
}
struct UIType: Codable{
    let type: String
    let values: [Value]
}

struct Value: Codable{
    let name: String
    let id: String
}
