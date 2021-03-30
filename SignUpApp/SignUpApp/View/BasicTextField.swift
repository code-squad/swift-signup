//
//  BasicTextField.swift
//  SignUpApp
//
//  Created by sonjuhyeong on 2021/03/30.
//

import UIKit

class BasicTextField: UITextField {
    
    override init(frame: CGRect){
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    func configure() {
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.systemGray.cgColor
    }
}
