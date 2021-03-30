//
//  UserRegisterForm.swift
//  swift-signup
//
//  Created by 박정하 on 2021/03/29.
//

import UIKit

class UserRegisterFormElement : UIView{
    private var titleLabel : UILabel! // textField와의 차이 21
    private var inputTextField : UITextField! // issueMessage와 차이 39
    private var issueMessage : UILabel!
    
    init(frame: CGRect, title: String, placeholder : String, posindex : Int) {
        super.init(frame: frame)
        titleLabel = initTitle(Label: title, index: CGFloat(posindex))
        inputTextField = initTextField(placeholder: placeholder)
        issueMessage = UILabel()
    }
    
    required init?(coder: NSCoder) {
        titleLabel = UILabel()
        inputTextField = UITextField()
        issueMessage = UILabel()
        super.init(coder: coder)
    }
    
    private func initTitle(Label : String, index : CGFloat) -> UILabel{
        let label : UILabel = UILabel()
        label.text = Label
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.frame.origin = CGPoint(x: 0, y: 0)
        label.sizeToFit()
        self.addSubview(label)
        return label
    }
    
    private func initTextField(placeholder : String) -> UITextField {
        let textField : UITextField = UITextField()
        textField.frame = CGRect(x: self.titleLabel.frame.origin.x, y: self.titleLabel.frame.origin.y + 21, width: 302, height: 38)
        textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.font : UIFont.systemFont(ofSize: 14)])
        textField.placeholder = placeholder
        textField.backgroundColor = .white
        textField.borderStyle = UITextField.BorderStyle.line
        textField.autoresizesSubviews = true
        textField.adjustsFontSizeToFitWidth = true
        self.addSubview(textField)
        return textField
    }
    
    private func initissueMessage() -> UILabel {
        let issueMessage : UILabel = UILabel()
        return issueMessage
    }
}
