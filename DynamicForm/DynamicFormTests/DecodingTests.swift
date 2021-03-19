//
//  DecodingTests.swift
//  DynamicFormTests
//
//  Created by Fábio Maciel de Sousa on 18/03/21.
//

import XCTest
@testable import DynamicForm

class DecodingTests: XCTestCase {

    let fileName = "form.json"
    
    func testDecodeModel() {
        guard let url = Bundle(for: DecodingTests.self).url(forResource: fileName, withExtension: nil),
              let data = try? Data(contentsOf: url) else {
            fatalError("File couldn't be loaded!")
        }
        let decoder = JSONDecoder()
        guard let wrapper = try? decoder.decode(Wrapper<Form>.self, from: data),
              let sut = wrapper.result.fields.first else {
            fatalError("Couldn't decode object!")
        }
        XCTAssertEqual(sut.name, "sc_no")
        XCTAssertEqual(sut.placeholder, "SC Number (e.g 309.11.012A)")
        XCTAssert(sut.regex.isEmpty)
        XCTAssertEqual(sut.dataType, .string)
        XCTAssertTrue(sut.isMandatory)
        XCTAssertEqual(sut.hintText, "e.g.(139.22.020)")
        XCTAssertEqual(sut.type, .textfield)
    }

}
