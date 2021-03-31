//
//  ViewController.swift
//  swift-signup
//
//  Created by 박정하 on 2021/03/29.
//

import UIKit

class ViewController: UIViewController {
    var signupView : SignUpView
    
    init() {
        signupView = SignUpView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        signupView = SignUpView()
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        signupView.frame.size = self.view.frame.size
        self.view.addSubview(signupView)
        super.viewDidLoad()
    }
}
