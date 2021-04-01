
import Foundation
import UIKit

class IdTextFieldDelegate : NSObject, UITextFieldDelegate {

    private var validater : IdValidater
    
    override init() {
        self.validater = IdValidater()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = (textField.text ?? "") as NSString
        let newText = text.replacingCharacters(in: range, with: string)
                
        let messageInfo = validater.evaluate(with: newText)
        
        textField.layer.borderWidth = 1.0
        if validater.state() == .valid {
            textField.layer.borderColor = UIColor.systemGreen.cgColor
        } else {
            textField.layer.borderColor = UIColor.red.cgColor
        }
        
        NotificationCenter.default.post(name: IdTextFieldDelegate.idTextFieldInfo, object: self, userInfo: messageInfo)
        return true
    }

    //MARK: 선택이 되면 파란색 테두리
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.systemBlue.cgColor
        return true
    }

    //MARK: 선택이 끝나면 상태에 따라 테두리 색 변경
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        textField.layer.borderWidth = 1.0
        validater.exitTextField()
        
        if validater.state() == .invalid {
            textField.layer.borderColor = UIColor.red.cgColor
        } else {
            textField.layer.borderColor = UIColor.systemGray3.cgColor
        }
        
        return true
    }
}

extension IdTextFieldDelegate {
    static let idTextFieldInfo = Notification.Name("idTextFieldInfo")
}
