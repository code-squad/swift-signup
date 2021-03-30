
import Foundation
import UIKit

class PasswordConfirmTextField : CustomTextField {
  
    private var password : String
    
    override init(frame: CGRect) {
        self.password = ""
        super.init(frame: frame)
        self.isSecureTextEntry = true
    }
    
    required init?(coder: NSCoder) {
        self.password = ""
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
                
        isValid(password: text)
        stateToColor()
        return true
    }
    
    func isValid(password: String) {
        var info : [AnyHashable:Any] = [:]

        if self.password == password {
            self.currentState = .valid
            info.updateValue("비밀번호가 일치합니다.", forKey: MessageInfo.text)
            info.updateValue(UIColor.systemGreen, forKey: MessageInfo.color)
        }
        else {
            self.currentState = .invalid
            info.updateValue("비밀번호가 일치하지 않습니다.", forKey: MessageInfo.text)
            info.updateValue(UIColor.red, forKey: MessageInfo.color)
        }
        
        NotificationCenter.default.post(name: CustomTextField.passwordConfirmState, object: self, userInfo: info)
    }
    
    func update(password: String) {
        self.password = password
    }
    

}
