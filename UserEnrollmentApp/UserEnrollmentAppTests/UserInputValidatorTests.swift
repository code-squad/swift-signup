//
//  UserInputValidator.swift
//  UserEnrollmentAppTests
//
//  Created by 조중윤 on 2021/03/30.
//

import XCTest
@testable import UserEnrollmentApp

class UserInputValidatorTests: XCTestCase {
    
    override func setUp() {
    }

    override func tearDown() {
    }

    func test_invalid_id_is_invalid() {
        let invalidId1 = "sdfw"
        let invalidId2 = "sdfwsdfwsdfwsdfwsdfwsdfwsdfwsdfw"
        let invalidId3 = "sdsdfdfsdf!!!@#@#@"
        
        XCTAssertFalse(UserInputValidator.validateId(invalidId1))
        XCTAssertFalse(UserInputValidator.validateId(invalidId2))
        XCTAssertFalse(UserInputValidator.validateId(invalidId3))
    }
    
    func test_valid_id_is_valid() {
        let validId1 = "sdfwf"
        let validId2 = "12345-_-"
        let validId3 = "sddjfksldfjsdie("
        
        XCTAssertTrue(UserInputValidator.validateId(validId1))
        XCTAssertTrue(UserInputValidator.validateId(validId2))
        XCTAssertTrue(UserInputValidator.validateId(validId3))
    }
    
    func test_password_is_short_or_long() {
        let shortPassword = "1233jdf"
        let longPassword = "1233jdf1233jdf1233jdf1233jdf"
        
        XCTAssertFalse(UserInputValidator.validatePasswordLength(shortPassword))
        XCTAssertFalse(UserInputValidator.validatePasswordLength(longPassword))
    }
    
    func test_password_does_not_contain_capital_letter() {
        let passwordWithoutCapitalLetter1 = "sdfsdf123123"
        let passwordWithoutCapitalLetter2 = "sdfsd%f123123"
        
        XCTAssertFalse(UserInputValidator.validatePasswordContainsCapitalLetter(passwordWithoutCapitalLetter1))
        XCTAssertFalse(UserInputValidator.validatePasswordContainsCapitalLetter(passwordWithoutCapitalLetter2))
    }
    
    func test_password_does_not_contain_number() {
        let passwordWithoutNumber1 = "sdfsdfsdfsdf"
        let passwordWithoutNumber2 = "sdfsd%fsdfdf"
        let passwordWithNumber1 = "123123sdf"
        
        XCTAssertFalse(UserInputValidator.validatePasswordContainsNumber(passwordWithoutNumber1))
        XCTAssertFalse(UserInputValidator.validatePasswordContainsNumber(passwordWithoutNumber2))
        XCTAssertTrue(UserInputValidator.validatePasswordContainsNumber(passwordWithNumber1))
    }
    
    func test_password_does_not_contain_special_letter() {
        let passwordWithoutSpecialLetter1 = "sdfsdf123123"
        let passwordWithSpecialLetter1 = "sdfsd%f123123"
        
        XCTAssertFalse(UserInputValidator.validatePasswordContainsSpecialCharacter(passwordWithoutSpecialLetter1))
        XCTAssertTrue(UserInputValidator.validatePasswordContainsSpecialCharacter(passwordWithSpecialLetter1))
    }
    
    func test_name_is_not_empty() {
        let emptyName = ""
        let validName = "jeje"
        
        XCTAssertFalse(UserInputValidator.validateName(emptyName))
        XCTAssertTrue(UserInputValidator.validateName(validName))
    }
    
    func test_id_is_not_duplicated() {
        let existingId1 = "jkhome"
        let existingId2 = "sarah"
        let newId = "jeje"
        
        XCTAssertTrue(UserInputValidator.IdIsNotDuplicated(newId))
        XCTAssertFalse(UserInputValidator.IdIsNotDuplicated(existingId1))
        XCTAssertFalse(UserInputValidator.IdIsNotDuplicated(existingId2))
    }
}
