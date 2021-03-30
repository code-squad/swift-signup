
import Foundation
import UIKit

class CustomTextField : UITextField, UITextFieldDelegate {
    
    enum State {
        case begin
        case valid
        case invalid
        case end
    }
    
    var currentState : State!
    
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
}

extension CustomTextField {
    enum UserInfo {
        case textInfo
        case colorInfo
    }
    
    static let idState = Notification.Name("idState")
    static let passwordState = Notification.Name("passwordState")
}
