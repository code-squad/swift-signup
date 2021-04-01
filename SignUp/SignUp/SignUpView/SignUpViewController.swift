//
//  ViewController.swift
//  SignUp
//
//  Created by 이다훈 on 2021/03/29.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet var categoryLabelCollection: [UILabel]!
    @IBOutlet var textFieldCollection: [SignUpTextField]!
    @IBOutlet var informationLabelCollection: [UILabel]!
    
    private let textFieldDelegate = TextFieldDelegate()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextField()
    }
    
    private func configureTextField() {
        for index in 0..<textFieldCollection.count {
            textFieldCollection[index].textFieldType = TextFieldType(rawValue: index)
            textFieldCollection[index].delegate = textFieldDelegate
            textFieldCollection[index].relatedLabel = informationLabelCollection[index]
        }
    }
    
    @IBAction func nextButtonTouched(_ sender: Any) {
        //nextView
    }
}

