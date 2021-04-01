//
//  PrivateDataViewController.swift
//  SignUp
//
//  Created by HOONHA CHOI on 2021/04/01.
//

import UIKit

class PrivateDataViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func goBackButtonTouched(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
