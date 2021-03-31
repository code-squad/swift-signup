//
//  ViewController.swift
//  SignupApp
//
//  Created by Issac on 2021/03/29.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {    
    @IBOutlet var basicInfomationLabelViewModel: BasicInfomationLabelViewModel!
    @IBOutlet var basicInfomationTextFieldViewModel: BasicInfomationTextFieldViewModel!
    
    var existIDs = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        basicInfomationTextFieldViewModel.initTarget()
        
        basicInfomationTextFieldViewModel.bind { (result) in
            self.basicInfomationLabelViewModel.changeIDStyle(result: result.ID)
            self.basicInfomationLabelViewModel.changePasswordStyle(result: result.password)
            self.basicInfomationLabelViewModel.changeCheckPasswordStyle(result:result.equalPassword)
            self.basicInfomationLabelViewModel.changeNameStyle(result: result.name)
        }
    }
}

extension ViewController {
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        super.touchesBegan(touches, with: event)
//        self.view.endEditing(true)
//    }
}
