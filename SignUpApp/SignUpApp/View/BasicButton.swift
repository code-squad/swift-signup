//
//  BasicButton.swift
//  SignUpApp
//
//  Created by sonjuhyeong on 2021/03/30.
//

import UIKit

class BasicButton: UIButton {
    
    override init(frame: CGRect){
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    func configure() {
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1.0
        self.isEnabled = false
        self.setTitleColor(.gray, for: .normal)
    }
}
