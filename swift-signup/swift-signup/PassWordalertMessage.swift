//
//  PassWordalertMessage.swift
//  swift-signup
//
//  Created by 박정하 on 2021/03/30.
//

import UIKit

class PassWordalertMessage : UILabel{
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.font = UIFont.systemFont(ofSize: 12)
        self.textAlignment = .left
        self.sizeToFit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func update(alertMessage : String){
        self.text = alertMessage
        self.sizeToFit()
    }
}
