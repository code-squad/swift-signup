//
//  SceneTitleLabel.swift
//  SignUpApp
//
//  Created by jinseo park on 3/29/21.
//

import UIKit

class SceneTitleLabel: UILabel {
    
    init(text : String) {
        super.init(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        super.text = text
        super.textColor = .green
        super.textAlignment = .center
        super.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func autoLayOutLabel(view : UIView) {
        super.topAnchor.constraint(equalTo: view.topAnchor
                    ,constant: 100).isActive = true
        super.leftAnchor.constraint(equalTo: view.leftAnchor
                    , constant: 40).isActive = true
        super.rightAnchor.constraint(equalTo: view.rightAnchor
                    , constant: -40).isActive = true
    }
    
}
