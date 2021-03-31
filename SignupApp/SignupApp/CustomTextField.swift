//
//  CustomTextField.swift
//  SignupApp
//
//  Created by Issac on 2021/03/29.
//

import UIKit

class CustomTextField: UITextField, ObservableObject {
    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    public func failorStyle() {
        self.layer.borderColor = #colorLiteral(red: 0.7830513277, green: 0.2840242443, blue: 0.3156971657, alpha: 1)
        self.layer.borderWidth = 1
    }
    
    public func defaultStyle() {
        self.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.layer.borderWidth = 1
    }
    
    public func typingStyle() {
        self.layer.borderColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        self.layer.borderWidth = 1
    }
}


