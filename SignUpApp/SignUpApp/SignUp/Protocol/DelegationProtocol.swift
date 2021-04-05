//
//  DelegationProtocol.swift
//  SignUpApp
//
//  Created by Jun Ho JANG on 2021/04/02.
//

import Foundation

protocol CheckDelegation {
    func checkPassword()
    func checkID()
    func checkPasswordEquality()
    func checkUserNameInput()
    func buttonStateCondition() -> Bool
}
