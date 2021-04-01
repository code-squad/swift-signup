//
//  BasicInfomationButtonViewModel.swift
//  SignupApp
//
//  Created by Issac on 2021/04/01.
//

import UIKit

class BasicInfomationButtonViewModel: NSObject {
    @IBOutlet weak var nextButton: UIButton!
    
    public func checkActivatedOrNot(result: ResultValidate) {
        switch result {
        case (.correct, .correct, .equal, .correct): nextButton.isEnabled = true
        default: nextButton.isEnabled = false
        }
    }
    
}
