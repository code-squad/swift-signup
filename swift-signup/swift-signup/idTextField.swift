
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
        guard let text = textField.text else {
            return false
        }
        
        if isValidId(string: "\(text)\(string)") {
            self.currentState = .valid
        } else {
            self.currentState = .invalid
        }
        stateToColor()
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.layer.borderColor = UIColor.blue.cgColor
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if self.currentState == .valid || self.currentState == .end {
            self.currentState = .end
        }
        stateToColor()
        return true
    }
    
    func isValidId(string: String) -> Bool {
        let idRegEx = "[A-Za-z0-9_-]{5,20}"
        let validString = NSPredicate(format: "SELF MATCHES %@", idRegEx)

        return validString.evaluate(with: string)
    }
}
