//
//  SignUpButton.swift
//  SignUp
//
//  Created by 오킹 on 2021/03/30.
//

import UIKit

class SignUpButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        self.layer.borderColor = CGColor(red: 112, green: 112, blue: 112, alpha: 1)
        self.layer.borderWidth = 1.0
    }
}
