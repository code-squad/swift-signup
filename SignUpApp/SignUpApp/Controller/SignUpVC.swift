//
//  ViewController.swift
//  SignUpApp
//
//  Created by jinseo park on 3/29/21.
//

import UIKit

class SignUpVC : UIViewController {

    var sceneTitleLabel : SceneTitleLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneTitleLabel = SceneTitleLabel(text: SceneTitle.SignUp.rawValue)
        self.view.addSubview(sceneTitleLabel)
        sceneTitleLabel.autoLayOutLabel(view: self.view)
        
    }

}

