
import Foundation
import UIKit

class idTextField : UITextField, UITextFieldDelegate {
    
    enum State {
        case begin
        case valid
        case invalid
        case end
    }
    
    private var currentState : State!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.currentState = .begin
        self.layer.borderWidth = 1.0
        stateToColor()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.currentState = .begin
        self.layer.borderWidth = 1.0
        stateToColor()
    }
    
    func stateToColor() {
        switch self.currentState {
        case .begin:
            self.layer.borderColor = UIColor.systemGray3.cgColor
        case .valid:
            self.layer.borderColor = UIColor.systemGreen.cgColor
        case .invalid:
            self.layer.borderColor = UIColor.red.cgColor
        case .end:
            self.layer.borderColor = UIColor.systemGray3.cgColor
        default:
            return
        }
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
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.layer.borderColor = UIColor.systemBlue.cgColor
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if self.currentState == .valid || self.currentState == .end {
            self.currentState = .end
        }
        stateToColor()
        return true
    }
    
    func isValidId(string: String) {
        let idRegEx = "[a-z0-9_-]{5,20}"
        let validString = NSPredicate(format: "SELF MATCHES %@", idRegEx)

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
        NotificationCenter.default.post(name: idTextField.idState, object: self, userInfo: info)
        
    }
}

extension idTextField {
    enum UserInfo {
        case textInfo
        case colorInfo
    }
    
    static let idState = Notification.Name("idState")
}
