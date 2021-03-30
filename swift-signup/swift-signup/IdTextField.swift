
import Foundation
import UIKit

class IdTextField : CustomTextField {
    
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
        let idRegularExpression = "[a-z0-9_-]{5,20}"
        let validString = NSPredicate(format: "SELF MATCHES %@", idRegularExpression)

        var info : [AnyHashable:Any] = [:]
        
        if validString.evaluate(with: string) {
            info.updateValue("사용 가능한 아이디입니다.", forKey: UserInfo.textInfo)
            info.updateValue(UIColor.systemGreen, forKey: UserInfo.colorInfo)
            self.currentState = .valid
        } else {
            info.updateValue("5~20자의 영문 소문자, 숫자와 특수기호(_)(-)만 사용 가능합니다.", forKey: UserInfo.textInfo)
            info.updateValue(UIColor.red, forKey: UserInfo.colorInfo)
            self.currentState = .invalid
        }
        NotificationCenter.default.post(name: IdTextField.idState, object: self, userInfo: info)
        
    }
}
