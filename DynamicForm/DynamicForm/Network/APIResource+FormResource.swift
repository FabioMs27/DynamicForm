//
//  Resource.swift
//  DynamicForm
//
//  Created by Fábio Maciel de Sousa on 17/05/21.
//

import Foundation

protocol APIResource {
    associatedtype ModelType: Decodable
    var urlPath: String { get }
    var method: String { get }
}

struct FormResource: APIResource {
    typealias ModelType = Form
    var urlPath: String { "https://api-staging.bankaks.com/task/\(option)" }
    var method: String { "POST" }
    let option: Int
    
    init(option: Int = 1) {
        self.option = option
    }
}

struct MockedResource: APIResource {
    typealias ModelType = Fields
    var urlPath: String = ""
    var method: String = ""
}
