//
//  URLSession.swift
//  DynamicForm
//
//  Created by Fábio Maciel de Sousa on 17/03/21.
//

import Foundation

protocol URLSessionProtocol {
    typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void
    func dataTaskWith(url: URL, completionHandler: @escaping DataTaskResult) -> URLSessionTaskProtocol
}

extension URLSession: URLSessionProtocol {
    func dataTaskWith(url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionTaskProtocol {
        dataTask(with: url, completionHandler: completionHandler) as URLSessionTaskProtocol
    }
}

protocol URLSessionTaskProtocol {
    func resume()
}

extension URLSessionTask: URLSessionTaskProtocol {}
