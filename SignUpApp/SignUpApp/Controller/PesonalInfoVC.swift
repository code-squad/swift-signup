//
//  PesonalInfoVC.swift
//  SignUpApp
//
//  Created by jinseo park on 3/29/21.
//

import UIKit

class PesonalInfoVC: UIViewController {

    var sceneTitleLabel : SceneTitleLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneTitleLabel = SceneTitleLabel(text: SceneTitle.PersonalInfo.rawValue)
        self.view.addSubview(sceneTitleLabel)
        sceneTitleLabel.autoLayOutLabel(view: self.view)
        
    }

}
