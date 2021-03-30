//
//  TextFieldsWithValidation.swift
//  UserEnrollmentApp
//
//  Created by 조중윤 on 2021/03/29.
//

import UIKit

protocol ResultNotifyingDelegate {
    func passValidationResult(sender: UITextFieldDelegate, result: Bool, explanation: String)
    func passTextFieldValue(sender: UITextFieldDelegate, value: String)
}
