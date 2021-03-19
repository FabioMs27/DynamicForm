//
//  NetworkingTests.swift
//  DynamicFormTests
//
//  Created by Fábio Maciel de Sousa on 18/03/21.
//

import XCTest
@testable import DynamicForm

class NetworkingTests: XCTestCase {
    
    var network: NetworkRequest!
    var urlPath: URL!
    let session = MockedSession()
    let fileName = "form.json"

    override func setUpWithError() throws {
        network = APIRequest(session: session)
        guard let url = Bundle(for: NetworkingTests.self).url(forResource: fileName, withExtension: nil) else {
            fatalError("URL not valid!")
        }
        urlPath = url
    }

    func testSuccessfulRequest() {
        var sut: Form?
        session.data = try? Data(contentsOf: urlPath)
        session.response = HTTPURLResponse(
            url: urlPath,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        session.error = nil
        network.request(urlPath: urlPath.absoluteString, modelType: Form.self) { result in
            switch result {
            case .success(let model):
                sut = model
            case .failure(_): break
            }
        }
        XCTAssertNotNil(sut)
    }
    
    func testConnectionError() {
        var sut: Error?
        session.data = nil
        session.response = nil
        session.error = NetworkError.unknownError
        network.request(urlPath: urlPath.absoluteString, modelType: Form.self) { result in
            switch result {
            case .success(_): break
            case .failure(let error):
                sut = error
            }
        }
        XCTAssertEqual(
            sut?.localizedDescription,
            NetworkError.connectionError.localizedDescription
        )
    }
    
    func testResponseError() {
        var sut: Error?
        session.data = nil
        session.response = HTTPURLResponse(
            url: urlPath,
            statusCode: 199,
            httpVersion: nil,
            headerFields: nil
        )
        session.error = nil
        network.request(urlPath: urlPath.absoluteString, modelType: Form.self) { result in
            switch result {
            case .success(_): break
            case .failure(let error):
                sut = error
            }
        }
        XCTAssertEqual(
            sut?.localizedDescription,
            NetworkError.invalidResponseType.localizedDescription
        )
    }
    
    func testUrlError() {
        var sut: Error?
        network.request(urlPath: "", modelType: Form.self) { result in
            switch result {
            case .success(_): break
            case .failure(let error):
                sut = error
            }
        }
        XCTAssertEqual(
            sut?.localizedDescription,
            NetworkError.invalidURL.localizedDescription
        )
    }
    
    func testDecodingError() {
        var sut: Error?
        session.data = try? Data(contentsOf: urlPath)
        session.response = HTTPURLResponse(
            url: urlPath,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        session.error = nil
        network.request(urlPath: urlPath.absoluteString, modelType: Fields.self) { result in
            switch result {
            case .success(_): break
            case .failure(let error):
                sut = error
            }
        }
        XCTAssertEqual(
            sut?.localizedDescription,
            NetworkError.objectNotDecoded.localizedDescription
        )
    }
}
