//
//  UserInputValidator.swift
//  UserEnrollmentAppTests
//
//  Created by 조중윤 on 2021/03/30.
//

import XCTest
@testable import UserEnrollmentApp

class UserInputValidatorTests: XCTestCase {
    var idRegex: String!
    
    override func setUp() {
        self.idRegex = "[a-z0-9_)(-]{5,20}"
    }

    override func tearDown() {
        self.idRegex = nil
    }

    func test_invalid_id_is_invalid() {
        let invalidId1 = "sdfw"
        let invalidId2 = "sdfwsdfwsdfwsdfwsdfwsdfwsdfwsdfw"
        let invalidId3 = "sdsdfdfsdf!!!@#@#@"
        
        XCTAssertFalse(UserInputValidator.valiidateId(invalidId1, with: idRegex))
        XCTAssertFalse(UserInputValidator.valiidateId(invalidId2, with: idRegex))
        XCTAssertFalse(UserInputValidator.valiidateId(invalidId3, with: idRegex))
    }
    
    func test_valid_id_is_valid() {
        let validId1 = "sdfwf"
        let validId2 = "12345-_-"
        let validId3 = "sddjfksldfjsdie("
        
        XCTAssertTrue(UserInputValidator.valiidateId(validId1, with: idRegex))
        XCTAssertTrue(UserInputValidator.valiidateId(validId2, with: idRegex))
        XCTAssertTrue(UserInputValidator.valiidateId(validId3, with: idRegex))
    }
}
