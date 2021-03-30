//
//  TextFieldsWithValidation.swift
//  UserEnrollmentApp
//
//  Created by 조중윤 on 2021/03/29.
//

import UIKit

protocol ResultNotifyingDelegate {
    func showValidationResult(sender: UITextFieldDelegate, result: Bool, explanation: String)
}
