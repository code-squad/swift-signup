//
//  ResultExplanationLabel.swift
//  UserEnrollmentApp
//
//  Created by 조중윤 on 2021/03/30.
//

import UIKit

class ResultExplanationLabel: UILabel {
    func setTextColor(isGoodExplanation: Bool) {
        if isGoodExplanation {
            self.textColor = UIColor.systemGreen
        } else {
            self.textColor = UIColor.systemRed
        }
    }
}
