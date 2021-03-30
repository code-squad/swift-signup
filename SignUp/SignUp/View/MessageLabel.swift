//
//  MessageLabel.swift
//  SignUp
//
//  Created by HOONHA CHOI on 2021/03/30.
//

import UIKit

class MessageLabel: UILabel {
    
    func fail() {
        self.textColor = .red
    }
    
    func succeed() {
        self.textColor = .systemGreen
    }

    func setText(_ text : String) {
        self.text = text
    }
}
