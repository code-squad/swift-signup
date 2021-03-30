
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
        guard var text = textField.text else {
            return false
        }
        
        if range.length != 0 {
            let removeRange = text.index(text.startIndex, offsetBy: range.location)..<text.index(text.startIndex, offsetBy: range.location + range.length)
            text.removeSubrange(removeRange)
        } else {
            text.insert(contentsOf: string, at: text.index(text.startIndex, offsetBy: range.location))
        }
                
        isValidId(string: text)
        stateToColor()
        return true
    }
    
    func isValidId(string: String) {
        let capitalRegularExpression = "[A-Z]+"
        let numberRegularExpression = "[0-9]+"
        let specialRegularExpression = "[!@#$%^&*()_+=-]+"
        
        var info : [AnyHashable:Any] = [:]
        
        if string.count < 8 || string.count > 16 {
            info.updateValue("8자 이상 16자 이하로 입력해주세요.", forKey: UserInfo.textInfo)
            info.updateValue(UIColor.red, forKey: UserInfo.colorInfo)
            self.currentState = .invalid
        }
        else if evaluate(regularExpression: capitalRegularExpression, with: string) == false
        {
            info.updateValue("영문 대문자를 최소 1자 이상 포함해주세요.", forKey: UserInfo.textInfo)
            info.updateValue(UIColor.red, forKey: UserInfo.colorInfo)
            self.currentState = .invalid
        }
        else if evaluate(regularExpression: numberRegularExpression, with: string) == false
        {
            info.updateValue("숫자를 최소 1자 이상 포함해주세요.", forKey: UserInfo.textInfo)
            info.updateValue(UIColor.red, forKey: UserInfo.colorInfo)
            self.currentState = .invalid
        }
        else if evaluate(regularExpression: specialRegularExpression, with: string) == false
        {
            info.updateValue("특수문자를 최소 1자 이상 포함해주세요.", forKey: UserInfo.textInfo)
            info.updateValue(UIColor.red, forKey: UserInfo.colorInfo)
            self.currentState = .invalid
        }
        else
        {
            info.updateValue("안전한 비밀번호입니다.", forKey: UserInfo.textInfo)
            info.updateValue(UIColor.systemGreen, forKey: UserInfo.colorInfo)
            self.currentState = .valid
        }
        
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
