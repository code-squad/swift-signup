//
//  ViewController.swift
//  SignUp
//
//  Created by Ador on 2021/03/29.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var inputForId: UITextField!
    @IBOutlet weak var inputForPassword: UITextField!
    @IBOutlet weak var messageForId: UILabel!
    @IBOutlet weak var messageForPassword: UILabel!

    private let idFielddelegate = IdFieldDelegate()
    private let passwordFieldDelegate = PasswordFieldDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


}

