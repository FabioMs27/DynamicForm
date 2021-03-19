//
//  MockRequest.swift
//  DynamicForm
//
//  Created by Fábio Maciel de Sousa on 17/03/21.
//

import Foundation

class MockedSession {
    let dataTask = MockedSessionTask()
    var data: Data?
    var error: NetworkError?
    var response: HTTPURLResponse?
}

extension MockedSession: URLSessionProtocol {
    func dataTaskWith(url: URL, completionHandler: @escaping DataTaskResult) -> URLSessionTaskProtocol {
        completionHandler(data, response, error)
        return dataTask
    }
}

class MockedSessionTask: URLSessionTaskProtocol {
    func resume() { }
}
