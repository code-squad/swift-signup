//
//  MainTitle.swift
//  swift-signup
//
//  Created by 박정하 on 2021/03/30.
//

import UIKit

class MainTitleLabel : UILabel {
    
    init(frame : CGRect, text : String){
        super.init(frame: frame)
        self.text = text
        self.textAlignment = .left
        self.font = UIFont.boldSystemFont(ofSize: 30)
        self.textColor = .systemGreen
        self.sizeToFit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.text = text
        self.textAlignment = .left
        self.font = UIFont.boldSystemFont(ofSize: 30)
        self.textColor = .systemGreen
        self.sizeToFit()
    }
}
