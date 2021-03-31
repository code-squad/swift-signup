//
//  reEnterPasswordTextField.swift
//  swift-signup
//
//  Created by 박정하 on 2021/03/30.
//

import UIKit

class ReEnterPasswordTextField : UITextField {
    private let TextFieldDelegate : ReEnterPasswordTextFieldDelegate
    
    override init(frame: CGRect) {
        TextFieldDelegate = ReEnterPasswordTextFieldDelegate()
        super.init(frame: frame)
        self.delegate = TextFieldDelegate
        self.borderStyle = .line
        self.textColor = .black
        self.font = UIFont.systemFont(ofSize: 17)
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
    }
    
    required init?(coder: NSCoder) {
        TextFieldDelegate = ReEnterPasswordTextFieldDelegate()
        super.init(coder: coder)
        self.delegate = TextFieldDelegate
        self.borderStyle = .line
    }
}
