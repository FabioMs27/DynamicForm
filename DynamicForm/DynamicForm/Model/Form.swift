//
//  Form.swift
//  Bankaks-Assessment
//
//  Created by Fábio Maciel de Sousa on 29/11/20.
//

import Foundation

/// Api model.
struct Form: Codable{
    let status: String
    let message: String
    let result: Results
}
/// Api model.
struct Results: Codable{
    let number_of_fields: Int
    let screen_title: String
    let operator_name: String
    let service_id: String
    let fields: [Field]
}
/// Api model.
struct Field: Codable{
    let name: String
    let placeholder: String
    let regex: String
    let type: Type
    let ui_type: UIType
    let is_mandatory: String
    let hint_text: String
}
/// Api model.
struct Type : Codable{
    let data_type: String
    let is_array: String
    let array_name: String
}
/// Api model.
struct UIType: Codable{
    let type: String
    let values: [Value]
}
/// Api model.
struct Value: Codable{
    let name: String
    let id: String
}
