//
//  IDtitle.swift
//  swift-signup
//
//  Created by 박정하 on 2021/03/30.
//

import UIKit

class ObjectTitle : UILabel {
    
    init(frame: CGRect, text : String) {
        super.init(frame: frame)
        self.text = text
        self.font = .systemFont(ofSize: 14)
        self.textAlignment = .left
        self.textColor = .black
        self.sizeToFit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.text = ""
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
