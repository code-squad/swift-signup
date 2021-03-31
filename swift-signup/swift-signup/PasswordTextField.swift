
import Foundation
import UIKit

class PasswordTextField : CustomTextField {
  
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isSecureTextEntry = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.isSecureTextEntry = true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = (textField.text ?? "") as NSString
        let newText = text.replacingCharacters(in: range, with: string)
                
        isValid(password: newText)
        stateToColor()
        return true
    }
    
    func isValid(password: String) {
        let capitalRegularExpression = "[A-Z]+"
        let numberRegularExpression = "[0-9]+"
        let specialRegularExpression = "[!@#$%^&*()_+=-]+"
        
        var info : [AnyHashable:Any] = [:]
        
        if password.count < 8 || password.count > 16 {
            info.updateValue("8자 이상 16자 이하로 입력해주세요.", forKey: MessageInfo.text)
            info.updateValue(UIColor.red, forKey: MessageInfo.color)
            self.currentState = .invalid
        }
        else if evaluate(regularExpression: capitalRegularExpression, with: password) == false
        {
            info.updateValue("영문 대문자를 최소 1자 이상 포함해주세요.", forKey: MessageInfo.text)
            info.updateValue(UIColor.red, forKey: MessageInfo.color)
            self.currentState = .invalid
        }
        else if evaluate(regularExpression: numberRegularExpression, with: password) == false
        {
            info.updateValue("숫자를 최소 1자 이상 포함해주세요.", forKey: MessageInfo.text)
            info.updateValue(UIColor.red, forKey: MessageInfo.color)
            self.currentState = .invalid
        }
        else if evaluate(regularExpression: specialRegularExpression, with: password) == false
        {
            info.updateValue("특수문자를 최소 1자 이상 포함해주세요.", forKey: MessageInfo.text)
            info.updateValue(UIColor.red, forKey: MessageInfo.color)
            self.currentState = .invalid
        }
        else
        {
            info.updateValue("안전한 비밀번호입니다.", forKey: MessageInfo.text)
            info.updateValue(UIColor.systemGreen, forKey: MessageInfo.color)
            self.currentState = .valid
        }
        
        info.updateValue(password, forKey: UserInfo.password)
        NotificationCenter.default.post(name: CustomTextField.passwordState, object: self, userInfo: info)
    }
    
    func evaluate(regularExpression: String, with string: String) -> Bool {
        let validString = try? NSRegularExpression(pattern: regularExpression, options: [])
        
        if validString?.firstMatch(in: string, options: [], range: NSRange(location: 0, length: string.count)) != nil {
            return true
        } else {
            return false
        }
        
    }
}

extension PasswordTextField {
    enum UserInfo {
        case password
    }
}
