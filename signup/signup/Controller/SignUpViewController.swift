//
//  ViewController.swift
//  signup
//
//  Created by Song on 2021/03/29.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet var signUpTextFieldModel: SignUpTextFieldModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        if signUpTextFieldModel.isAllFieldValidate() {
            //다음으로 넘어갈 준비가 되었다!
        }
    }
}
