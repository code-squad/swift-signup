//
//  CustomTextField.swift
//  swift-signup
//
//  Created by 박정하 on 2021/04/01.
//

import UIKit

class CustomTextField : UITextField {
    private let TextFieldDelegate : UITextFieldDelegate
    
    init(frame: CGRect, textfieldDelegate: UITextFieldDelegate, isSecure : Bool) {
        TextFieldDelegate = textfieldDelegate
        super.init(frame: frame)
        self.delegate = TextFieldDelegate
        self.borderStyle = .line
        self.textColor = .black
        self.font = UIFont.systemFont(ofSize: 17)
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
        self.isSecureTextEntry = isSecure
    }
    
    convenience init(frame: CGRect, textfieldDelegate: UITextFieldDelegate) {
        self.init(frame : frame, textfieldDelegate : textfieldDelegate, isSecure : true)
    }
    
    required init?(coder: NSCoder) {
        TextFieldDelegate = IDTextFieldDelegate(alertMessage: AlertMessage())
        super.init(coder: coder)
        self.delegate = TextFieldDelegate
    }
}
