
import Foundation
import UIKit

class CustomTextFieldDelegate : NSObject, UITextFieldDelegate {
    
    private var text : ((String, NSRange, String) -> Void)!
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.systemBlue.cgColor
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        self.text(textField.text ?? "", range, string)
        return true
    }
    
    func configureText(closure: @escaping ((String, NSRange, String) -> Void)) {
        self.text = closure
    }
}
