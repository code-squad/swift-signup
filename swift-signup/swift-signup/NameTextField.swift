//
//  NameTextField.swift
//  swift-signup
//
//  Created by 박정하 on 2021/03/30.
//

import UIKit

class NameTextField : UITextField {
    private let TextFieldDelegate : NameTextFieldDelegate
    
    override init(frame: CGRect) {
        TextFieldDelegate = NameTextFieldDelegate()
        super.init(frame: frame)
        self.delegate = TextFieldDelegate
        self.borderStyle = .line
        self.textColor = .black
        self.font = UIFont.systemFont(ofSize: 17)
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
    }
    
    required init?(coder: NSCoder) {
        TextFieldDelegate = NameTextFieldDelegate()
        super.init(coder: coder)
        self.delegate = TextFieldDelegate
        self.borderStyle = .line
    }
}
