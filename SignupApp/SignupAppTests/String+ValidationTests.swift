//
//  String+ValidationTests.swift
//  SignupAppTests
//
//  Created by Song on 2021/03/30.
//

import XCTest

class String_ValidationTests: XCTestCase {
    
    func test_SignupApp_ID_정규표현식_검증() throws {
        let idRegex = "[a-z0-9_-]{5,20}"
        
        XCTAssertTrue("12345".validate(with: idRegex))
        XCTAssertTrue("aaaaa".validate(with: idRegex))
        XCTAssertTrue("_____".validate(with: idRegex))
        XCTAssertTrue("-----".validate(with: idRegex))
        XCTAssertTrue("12345aaaaa__--".validate(with: idRegex))
        XCTAssertTrue("1234567890aaaabbbb_-".validate(with: idRegex))
        
        XCTAssertFalse("1234".validate(with: idRegex))
        XCTAssertFalse("12345%".validate(with: idRegex))
        XCTAssertFalse("AAAAA".validate(with: idRegex))
        XCTAssertFalse("12345678910aaaaabbbbbc".validate(with: idRegex))
    }
    
    func test_SignupApp_Password_길이_정규표현식_검증() throws {
        let passwordLengthRegex = ".{8,16}"
        
        XCTAssertTrue("12345Ab%".validate(with: passwordLengthRegex))
        XCTAssertTrue("12345678".validate(with: passwordLengthRegex))
        XCTAssertFalse("123Ab%".validate(with: passwordLengthRegex))
        XCTAssertFalse("1234567890AAABBB%%%".validate(with: passwordLengthRegex))
    }
    
    func test_SignupApp_Password_정규표현식_검증() throws {
        let passwordRegex = "(?=.*[A-Z])(?=.*[a-z])(?=.*\\d)(?=.*\\W)[\\S]{8,16}"
        
        XCTAssertTrue("12345Ab%".validate(with: passwordRegex))
        XCTAssertFalse("12345678".validate(with: passwordRegex))
        XCTAssertFalse("AAAAAAAA".validate(with: passwordRegex))
        XCTAssertFalse("aaaaaaaa".validate(with: passwordRegex))
        XCTAssertFalse("%%%%%%%%".validate(with: passwordRegex))
        XCTAssertFalse("12345Ab%   ".validate(with: passwordRegex))
        XCTAssertFalse("1234aaaa".validate(with: passwordRegex))
        XCTAssertFalse("1234AAAA".validate(with: passwordRegex))
        XCTAssertFalse("1234%%%%".validate(with: passwordRegex))
        XCTAssertFalse("aaaa%%%%".validate(with: passwordRegex))
    }
}
