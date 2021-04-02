//
//  signUpTests.swift
//  signUpTests
//
//  Created by 서우석 on 2021/03/29.
//

import XCTest
@testable import signUp

class signUpTests: XCTestCase {
    
    var regexManager = RegexValidManager()

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testInValidEmail() {
        XCTAssertFalse(regexManager.isValidStateForEmail("asdf@naver"))
        XCTAssertFalse(regexManager.isValidStateForEmail("asdf"))
    }
    
    func testValidEmail() {
        XCTAssertTrue(regexManager.isValidStateForEmail("asdf@naver.com"))
        XCTAssertTrue(regexManager.isValidStateForEmail("asdf@naver.co.kr"))
    }

}
