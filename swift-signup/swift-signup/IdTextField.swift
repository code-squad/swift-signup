
import Foundation
import UIKit

class IdTextField : CustomTextField {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = (textField.text ?? "") as NSString
        let newText = text.replacingCharacters(in: range, with: string)
                
        isValid(id: newText)
        stateToColor()
        return true
    }
    
    func isValid(id: String) {
        let idRegularExpression = "[a-z0-9_-]{5,20}"
        let validString = NSPredicate(format: "SELF MATCHES %@", idRegularExpression)

        var info : [AnyHashable:Any] = [:]
        
        if validString.evaluate(with: id) {
            info.updateValue("사용 가능한 아이디입니다.", forKey: MessageInfo.text)
            info.updateValue(UIColor.systemGreen, forKey: MessageInfo.color)
            self.currentState = .valid
        } else {
            info.updateValue("5~20자의 영문 소문자, 숫자와 특수기호(_)(-)만 사용 가능합니다.", forKey: MessageInfo.text)
            info.updateValue(UIColor.red, forKey: MessageInfo.color)
            self.currentState = .invalid
        }
        NotificationCenter.default.post(name: CustomTextField.idState, object: self, userInfo: info)
        
    }
}
