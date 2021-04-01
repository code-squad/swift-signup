//
//  InfoLabel.swift
//  signup
//
//  Created by Song on 2021/04/01.
//

import UIKit

class InfoLabel: UILabel {

    func update(isValidated: Bool, text: String){
        let color = isValidated ? ColorSet.PointGreen : ColorSet.PointRed
        textColor = color
        self.text = text
    }
    
}
