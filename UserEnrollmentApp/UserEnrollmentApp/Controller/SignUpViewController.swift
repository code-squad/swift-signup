//
//  ViewController.swift
//  UserEnrollmentApp
//
//  Created by 조중윤 on 2021/03/29.
//

import UIKit

class SignUpViewController: UIViewController {
    let idFieldDelegate = SignUpSceneIdFieldDelegate()
    
    @IBOutlet weak var idTextField: DesignableTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.idTextField.delegate = idFieldDelegate
    }
    
}
