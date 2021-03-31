
import Foundation
import UIKit

class NameTextField : CustomTextField {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = (textField.text ?? "") as NSString
        let newText = text.replacingCharacters(in: range, with: string)
                
        isValidId(string: newText)
        stateToColor()
        return true
    }
    
    func isValidId(string: String) {
        var info : [AnyHashable:Any] = [:]
        
        if string.isEmpty {
            info.updateValue("이름은 필수 입력 항목입니다.", forKey: MessageInfo.text)
            info.updateValue(UIColor.red, forKey: MessageInfo.color)
            self.currentState = .invalid
        } else {
            info.updateValue("", forKey: MessageInfo.text)
            info.updateValue(UIColor.systemGreen, forKey: MessageInfo.color)
            self.currentState = .valid
        }
        
        NotificationCenter.default.post(name: CustomTextField.nameState, object: self, userInfo: info)
    }
}
