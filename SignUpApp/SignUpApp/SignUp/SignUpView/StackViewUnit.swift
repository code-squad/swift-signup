//
//  StackViewUnit.swift
//  SignUpApp
//
//  Created by Jun Ho JANG on 2021/03/30.
//

import UIKit

class StackViewUnit: UIStackView {

    var title: UILabel!
    var textField: UITextField!
    var subLabel: UILabel!
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        configureTitleLabel()
        configureTextField()
        configureSubLabel()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureTitleLabel()
        configureTextField()
        configureSubLabel()
    }
    
    private func configureTitleLabel() {
        title = UILabel()
        title.textAlignment = .left
        title.textColor = .black
        title.font = UIFont(name: "HelveticaNeue-Bold", size: 14)
        self.addArrangedSubview(title)
    }
    
    private func configureTextField() {
        textField = UITextField()
        textField.layer.cornerRadius = 0
        textField.addConstraint(textField.heightAnchor.constraint(equalToConstant: 38))
        textField.addConstraint(textField.widthAnchor.constraint(equalToConstant: 302))
        textField.borderStyle = .bezel
        textField.keyboardType = .default
        textField.returnKeyType = .next
        
        textField.attributedPlaceholder = NSAttributedString(string: "", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 141, green: 141, blue: 141, alpha: 1)])
        self.addArrangedSubview(textField)
    }
    
    private func configureSubLabel() {
        subLabel = UILabel()
        subLabel.textAlignment = .left
        subLabel.textColor = .black
        subLabel.font = UIFont(name: "HelveticaNeue", size: 12)
        self.addArrangedSubview(subLabel)
    }
    
}

