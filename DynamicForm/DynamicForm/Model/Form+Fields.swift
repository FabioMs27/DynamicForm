//
//  Form.swift
//  Bankaks-Assessment
//
//  Created by Fábio Maciel de Sousa on 29/11/20.
//

import Foundation

enum DataType: String {
    case int
    case string
    case none
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
