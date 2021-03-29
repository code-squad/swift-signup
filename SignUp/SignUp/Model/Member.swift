//
//  Member.swift
//  SignUp
//
//  Created by 오킹 on 2021/03/29.
//

import Foundation

class Member {
    private let id: String
    private let pw: String
    private let name: String
    private let birth: Date
    private let gender: String
    private let email: String
    private let phoneNumber: String
    private let interest: String
    
    init(id: String, pw: String, name: String, birth: Date, gender: String, email: String, phoneNumber: String, interest: String) {
        self.id = id
        self.pw = pw
        self.name = name
        self.birth = birth
        self.gender = gender
        self.email = email
        self.phoneNumber = phoneNumber
        self.interest = interest
    }
}
