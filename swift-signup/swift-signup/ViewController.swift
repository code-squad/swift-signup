//
//  ViewController.swift
//  swift-signup
//
//  Created by user on 2021/03/29.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var idText: idTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.idText.delegate = idText
    }


}

