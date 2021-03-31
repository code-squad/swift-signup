//
//  SignUpViewController.swift
//  SignUp
//
//  Created by 박혜원 on 2021/03/29.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet var idViewModel: IDViewModel!
    @IBOutlet weak var idLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        idViewModel.bind(control: { [weak self] (state) in
            self?.idLabel.text = state.state.rawValue
        })

    }
    @IBAction func didTouchNextButton(_ sender: Any) {
        
        guard let personInfoVC = self.storyboard?.instantiateViewController(identifier: "personInform") as? PersonInformViewController else {
            return
        }
        personInfoVC.modalTransitionStyle = .coverVertical
        personInfoVC.modalPresentationStyle = .fullScreen
        present(personInfoVC, animated: true, completion: nil)
    }
}
