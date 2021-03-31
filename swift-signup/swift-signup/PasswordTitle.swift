//
//  PasswordTitle.swift
//  swift-signup
//
//  Created by 박정하 on 2021/03/30.
//

import UIKit

class PasswordTitle : UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.text = "비밀번호"
        self.font = .systemFont(ofSize: 14)
        self.textAlignment = .left
        self.textColor = .black
        self.sizeToFit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.text = "비밀번호"
        self.font = .systemFont(ofSize: 14)
        self.textAlignment = .left
        self.textColor = .black
        self.sizeToFit()
    }
    
    func update(Text : String){
        self.text = Text
        self.sizeToFit()
    }
}
