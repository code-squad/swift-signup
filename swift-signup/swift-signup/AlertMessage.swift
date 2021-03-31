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
        NotificationCenter.default.addObserver(self, selector: #selector(UpdateAlertMessage), name: NSNotification.Name("UpdateIdAlertMessage"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(UpdateCorrectMessage), name: NSNotification.Name("CorrectId"), object: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @objc private func UpdateAlertMessage(sender: Notification){
        guard let isText = sender.object as? String else {return}
        self.update(alertMessage: isText)
        self.textColor = .red
    }
    
    @objc private func UpdateCorrectMessage(sender: Notification){
        guard let isText = sender.object as? String else {return}
        self.update(alertMessage: isText)
        self.textColor = .green
    }
    
    func update(alertMessage : String){
        self.text = alertMessage
        self.sizeToFit()
    }
}
