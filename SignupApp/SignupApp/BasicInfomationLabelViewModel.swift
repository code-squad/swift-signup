//
//  BasicInfomationViewModel.swift
//  SignupApp
//
//  Created by Issac on 2021/03/30.
//

import UIKit
import Combine

class BasicInfomationLabelViewModel: NSObject {
    @IBOutlet weak var IDMessageLabel: UILabel!
    @IBOutlet weak var passwordMessageLabel: UILabel!
    @IBOutlet weak var checkPasswordMessageLabel: UILabel!
    @IBOutlet weak var nameMessageLabel: UILabel!
     
    @IBOutlet var messageLabels: [UILabel]!
    
    public func changeIDStyle(result: ResultIDChecking) {
        switch result {
        case .blank:
            self.changeStyle(to: IDMessageLabel, message: "", result: false)
        case .existID:
            self.changeStyle(to: IDMessageLabel, message: LabelMessage.existedID, result: false)
        case .incorrectID:
            self.changeStyle(to: IDMessageLabel, message: LabelMessage.incorrectID, result: false)
        case .correct:
            self.changeStyle(to: IDMessageLabel, message: LabelMessage.correctID, result: true)
        }
    }
    
    func changePasswordStyle(result: ResultPasswordChecking) {
        switch result {
        case .blank:
            self.changeStyle(to: passwordMessageLabel, message: "", result: false)
        case .notIncludeDigit:
            self.changeStyle(to: passwordMessageLabel, message: LabelMessage.requireMinimumDigit, result: false)
        case .notIncludeSpecialCharacter:
            self.changeStyle(to: passwordMessageLabel, message: LabelMessage.requireMinimumSpecialCharacter, result: false)
        case .notIncludeUppercaseLetter:
            self.changeStyle(to: passwordMessageLabel, message: LabelMessage.requireMinimumUpperCase, result: false)
        case .outOfCharacterLimit:
            self.changeStyle(to: passwordMessageLabel, message: LabelMessage.outOfCharacterLimitPassword, result: false)
        case .correct:
            self.changeStyle(to: passwordMessageLabel, message: LabelMessage.correctPassword, result: true)
        }
    }
    
    func changeCheckPasswordStyle(result: ResultEqualPasswordChecking) {
        switch result {
        case .blank:
            self.changeStyle(to: checkPasswordMessageLabel, message: "", result: false)
        case .notEqual:
            self.changeStyle(to: checkPasswordMessageLabel, message: LabelMessage.notEqualPassword, result: false)
        case .equal:
            self.changeStyle(to: checkPasswordMessageLabel, message: LabelMessage.equalPassword, result: true)
        }
    }
    
    func changeNameStyle(result: ResultNameChecking) {
        switch result {
        case .blank:
            self.changeStyle(to: nameMessageLabel, message: LabelMessage.requireFillNameIn, result: false)
        case .correct:
            self.changeStyle(to: nameMessageLabel, message: "", result: true)
        }
    }
    
    func changeStyle(to label: UILabel, message: String, result: Bool) {
        label.text = message
        label.textColor = result ? #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1) : #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
    }
}

extension BasicInfomationLabelViewModel {
    enum LabelMessage {
        static let correctID = "사용 가능한 아이디입니다."
        static let existedID = "이미 사용중인 아이디입니다."
        static let incorrectID = "5~20자의 영문 소문자, 숫자와 특수기호(_)(-)만 사용 가능합니다."
        static let outOfCharacterLimitPassword = "8자 이상 16자 이하로 입력해주세요."
        static let requireMinimumDigit = "숫자를 최소 1자 이상 포함해주세요."
        static let requireMinimumUpperCase = "영문 대문자를 최소 1자 이상 포함해주세요."
        static let requireMinimumSpecialCharacter = "특수문자를 최소 1자 이상 포함해주세요."
        static let correctPassword = "안전한 비밀번호입니다."
        static let equalPassword = "비밀번호가 일치합니다."
        static let notEqualPassword = "비밀번호가 일치하지 않습니다."
        static let requireFillNameIn = "이름은 필수 입력 항목입니다."
    }
}
