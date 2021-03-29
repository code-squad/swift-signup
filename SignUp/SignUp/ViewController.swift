//
//  ViewController.swift
//  SignUp
//
//  Created by 양준혁 on 2021/03/29.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var IDTextField: UITextField!
    var IdTextFieldDelegate = IDTextFieldDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        IDTextField.delegate = IdTextFieldDelegate
    }


}

