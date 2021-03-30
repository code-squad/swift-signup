//
//  ViewController.swift
//  SignupApp
//
//  Created by Song on 2021/03/29.
//

import UIKit

class BasicInfoViewController: UIViewController {
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var idMessageLabel: UILabel!
    @IBOutlet weak var passwordMessageLabel: UILabel!
    @IBOutlet weak var passwordConfirmMessageLabel: UILabel!
    @IBOutlet weak var nameMessageLabel: UILabel!
    
    @IBOutlet weak var nextButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


}

