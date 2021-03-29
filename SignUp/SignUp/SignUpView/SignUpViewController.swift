//
//  ViewController.swift
//  SignUp
//
//  Created by 이다훈 on 2021/03/29.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet var categoryLabelCollection: [UILabel]!
    @IBOutlet var textFieldCollection: [UITextField]!
    @IBOutlet var informationLabelCollection: [UILabel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCategorylabel()
        configureTextField()
        configureInformationLabel()
    }

    func configureCategorylabel() {
        for label in categoryLabelCollection {
            label.font = .boldSystemFont(ofSize: 17)
        }
    }
    
    func configureTextField() {
        for textfield in textFieldCollection {
            textfield.borderStyle = .line
        }
    }
    
    func configureInformationLabel() {
        for label in informationLabelCollection {
            label.font = .systemFont(ofSize: 12)
            label.isHidden = true
        }
    }

}

