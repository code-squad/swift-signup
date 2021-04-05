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
    @IBOutlet weak var nextButton: UIButton!
    
    private let textFieldDelegate = TextFieldDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextField()
        configureObserver()
    }
    
    private func configureTextField() {
        for index in 0..<textFieldCollection.count {
            textFieldCollection[index].textFieldType = TextFieldType(rawValue: index)
            textFieldCollection[index].delegate = textFieldDelegate
            textFieldCollection[index].relatedLabel = informationLabelCollection[index]
        }
    }
    
    private func configureObserver() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(changeRelatedUI(noti:)), name: .uiUpdate, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(buttonEnableCheck(noti:)), name: .nextButtonEnableCheck, object: textFieldDelegate)
    }
    
    @IBAction func nextButtonTouched(_ sender: Any) {
        //nextView
    }
    
    @objc func buttonEnableCheck(noti : Notification) {
        guard let buttonEnable = noti.userInfo?["enable"] as? Bool else {
            return
        }
        nextButton.isEnabled = buttonEnable
        
    }
    
    @objc func changeRelatedUI(noti : Notification) {
        guard let textField = noti.object as? SignUpTextField else {
            return
        }
        guard let result = noti.userInfo?["result"] as? ErrorResult else {
            return
        }
        textField.changeStyle(with: result)
    }
}

