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

    func testInvalidEmail() {
        XCTAssertFalse(regexManager.isValidStateForEmail("asdf@naver"))
        XCTAssertFalse(regexManager.isValidStateForEmail("asdf"))
    }
    
    func testValidEmail() {
        XCTAssertTrue(regexManager.isValidStateForEmail("asdf@naver.com"))
        XCTAssertTrue(regexManager.isValidStateForEmail("asdf@naver.co.kr"))
    }
    
    func testInvalidPhoneNumber() {
        XCTAssertFalse(regexManager.isValidStateForPhone("1234"))
        XCTAssertFalse(regexManager.isValidStateForPhone("010-1234-4567"))
    }
    
    func testValidPhoneNumber() {
        XCTAssertTrue(regexManager.isValidStateForPhone("01012345678"))
        XCTAssertTrue(regexManager.isValidStateForPhone("01087652987"))
    }
}
