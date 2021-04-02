
import Foundation
import UIKit

class PasswordValidater {
    
    enum State {
        case begin
        case valid
        case lengthInvalid
        case capitalInvalid
        case numberInvalid
        case specialInvalid
        case end
    }
    
    private var currentState: State
    
    init() {
        self.currentState = .begin
    }
    
    func evaluate(with text: String) -> [AnyHashable:Any] {
        let capitalRegularExpression = "[A-Z]+"
        let numberRegularExpression = "[0-9]+"
        let specialRegularExpression = "[!@#$%^&*()_+=-]+"
        
        if text.count < 8 || text.count > 16
        {
            self.currentState = .lengthInvalid
        }
        else if match(regularExpression: capitalRegularExpression, with: text) == false
        {
            self.currentState = .capitalInvalid
        }
        else if match(regularExpression: numberRegularExpression, with: text) == false
        {
            self.currentState = .numberInvalid
        }
        else if match(regularExpression: specialRegularExpression, with: text) == false
        {
            self.currentState = .specialInvalid
        }
        else
        {
            self.currentState = .valid
        }
        
        var messageInfo = message(about: self.currentState)
        messageInfo.updateValue(text, forKey: PasswordValidater.MessageInfo.password)
        return messageInfo
    }
    
    func match(regularExpression: String, with string: String) -> Bool {
        let validString = try? NSRegularExpression(pattern: regularExpression, options: [])
        
        if validString?.firstMatch(in: string, options: [], range: NSRange(location: 0, length: string.count)) != nil {
            return true
        } else {
            return false
        }
    }

    func message(about state: State) -> [AnyHashable:Any] {
        var messageInfo : [AnyHashable:Any] = [:]

        switch state {
        case .valid:
            messageInfo.updateValue("안전한 비밀번호입니다.", forKey: PasswordValidater.MessageInfo.text)
            messageInfo.updateValue(UIColor.systemGreen, forKey: PasswordValidater.MessageInfo.color)
        case .lengthInvalid:
            messageInfo.updateValue("8자 이상 16자 이하로 입력해주세요.", forKey: PasswordValidater.MessageInfo.text)
            messageInfo.updateValue(UIColor.red, forKey: PasswordValidater.MessageInfo.color)
        case .capitalInvalid:
            messageInfo.updateValue("영문 대문자를 최소 1자 이상 포함해주세요.", forKey: PasswordValidater.MessageInfo.text)
            messageInfo.updateValue(UIColor.red, forKey: PasswordValidater.MessageInfo.color)
        case .numberInvalid:
            messageInfo.updateValue("숫자를 최소 1자 이상 포함해주세요.", forKey: PasswordValidater.MessageInfo.text)
            messageInfo.updateValue(UIColor.red, forKey: PasswordValidater.MessageInfo.color)
        case .specialInvalid:
            messageInfo.updateValue("특수문자를 최소 1자 이상 포함해주세요.", forKey: PasswordValidater.MessageInfo.text)
            messageInfo.updateValue(UIColor.red, forKey: PasswordValidater.MessageInfo.color)
        default:
            break
        }
        
        return messageInfo
    }
    
    func state() -> State {
        return self.currentState
    }
    
    func exitTextField() {
        if self.currentState == .valid {
            self.currentState = .end
        }
    }
}

extension PasswordValidater {
    enum MessageInfo {
        case text
        case color
        case password
    }
}
