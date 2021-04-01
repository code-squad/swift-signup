//
//  issueMessage.swift
//  swift-signup
//
//  Created by 박정하 on 2021/03/30.
//

import UIKit

class AlertMessage : UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.font = UIFont.systemFont(ofSize: 12)
        self.textAlignment = .left
        self.sizeToFit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func UpdateAlertMessage(text: String){
        self.update(alertMessage: text)
        self.textColor = .red
    }
    
    func UpdateCorrectMessage(text: String){
        self.update(alertMessage: text)
        self.textColor = .green
    }
    
    private func update(alertMessage : String){
        self.text = alertMessage
        self.sizeToFit()
    }
}
