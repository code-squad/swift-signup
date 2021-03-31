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
    
    func test_SignupApp_Password_대문자포함_정규표현식_검증() throws {
        let passwordUppercaseRegex = "[^A-Z]*[A-Z].*"
        
        XCTAssertTrue("AAAAAAAA".validate(with: passwordUppercaseRegex))
        XCTAssertTrue("12345Ab%".validate(with: passwordUppercaseRegex))
        XCTAssertTrue("12345Ab%   ".validate(with: passwordUppercaseRegex))
        XCTAssertTrue("1234AAAA".validate(with: passwordUppercaseRegex))
        XCTAssertFalse("1234aaaa".validate(with: passwordUppercaseRegex))
        XCTAssertFalse("12345678".validate(with: passwordUppercaseRegex))
        XCTAssertFalse("aaaaaaaa".validate(with: passwordUppercaseRegex))
        XCTAssertFalse("%%%%%%%%".validate(with: passwordUppercaseRegex))
        XCTAssertFalse("aaaa%%%%".validate(with: passwordUppercaseRegex))
    }
    
    func test_SignupApp_Password_숫자포함_정규표현식_검증() throws {
        let passwordDigitRegex = "[^0-9]*[0-9].*"
        
        XCTAssertTrue("12345678".validate(with: passwordDigitRegex))
        XCTAssertTrue("12345Ab%".validate(with: passwordDigitRegex))
        XCTAssertTrue("12345Ab%   ".validate(with: passwordDigitRegex))
        XCTAssertTrue("1234AAAA".validate(with: passwordDigitRegex))
        XCTAssertTrue("1234aaaa".validate(with: passwordDigitRegex))
        XCTAssertFalse("AAAAAAAA".validate(with: passwordDigitRegex))
        XCTAssertFalse("aaaaaaaa".validate(with: passwordDigitRegex))
        XCTAssertFalse("%%%%%%%%".validate(with: passwordDigitRegex))
        XCTAssertFalse("aaaa%%%%".validate(with: passwordDigitRegex))
    }
    
    func test_SignupApp_Password_특수문자포함_정규표현식_검증() throws {
        let passwordSpecialCharacterRegex = "[^!@#$%]*[!@#$%].*"
        
        XCTAssertTrue("%%%%%%%%".validate(with: passwordSpecialCharacterRegex))
        XCTAssertTrue("aaaa%%%%".validate(with: passwordSpecialCharacterRegex))
        XCTAssertTrue("12345Ab%".validate(with: passwordSpecialCharacterRegex))
        XCTAssertTrue("12345Ab%   ".validate(with: passwordSpecialCharacterRegex))
        XCTAssertFalse("12345678".validate(with: passwordSpecialCharacterRegex))
        XCTAssertFalse("1234AAAA".validate(with: passwordSpecialCharacterRegex))
        XCTAssertFalse("1234aaaa".validate(with: passwordSpecialCharacterRegex))
        XCTAssertFalse("AAAAAAAA".validate(with: passwordSpecialCharacterRegex))
        XCTAssertFalse("aaaaaaaa".validate(with: passwordSpecialCharacterRegex))
    }
    
    func test_SignupApp_Password_정규표현식_검증() throws {
        let passwordRegex = "[A-Za-z0-9!@#$%]*"
        
        XCTAssertTrue("12345678".validate(with: passwordRegex))
        XCTAssertTrue("AAAAAAAA".validate(with: passwordRegex))
        XCTAssertTrue("aaaaaaaa".validate(with: passwordRegex))
        XCTAssertTrue("%%%%%%%%".validate(with: passwordRegex))
        XCTAssertTrue("1234AAAA".validate(with: passwordRegex))
        XCTAssertTrue("aaaa%%%%".validate(with: passwordRegex))
        XCTAssertFalse("12345Ab%   ".validate(with: passwordRegex))
        XCTAssertFalse("12345Ab_".validate(with: passwordRegex))
    }
}
