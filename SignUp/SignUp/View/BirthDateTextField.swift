//
//  BirthDateTextField.swift
//  SignUp
//
//  Created by HOONHA CHOI on 2021/04/01.
//

import UIKit

class BirthDateTextField: UITextField {

    private var birthDatePicker : BirthDatePicker
    private let toolbar : UIToolbar = {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "확인", style: .plain, target: nil, action : #selector(doneButtonTouched(_:)))
        toolBar.setItems([doneButton], animated: true)
        return toolBar
    }()
    
    override init(frame: CGRect) {
        birthDatePicker = BirthDatePicker()
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        birthDatePicker = BirthDatePicker()
        super.init(coder: coder)
        configure()
    }
    
    func configure() {
        self.inputView = birthDatePicker
        self.inputAccessoryView = toolbar
    }
    
    @objc func doneButtonTouched(_ sender : UIBarButtonItem) {
        self.text = birthDatePicker.deformString(birthDatePicker.date)
    }
}
