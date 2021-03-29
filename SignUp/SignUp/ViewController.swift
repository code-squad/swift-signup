//
//  ViewController.swift
//  SignUp
//
//  Created by HOONHA CHOI on 2021/03/29.
//

import UIKit
import Combine

class ViewController: UIViewController {

    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var pwConfirmTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var idValidLabel: UILabel!
    @IBOutlet weak var pwValidLabel: UILabel!
    @IBOutlet weak var pwConfirmVaildLabel: UILabel!
    @IBOutlet weak var nameValidLabel: UILabel!
    
    @IBOutlet weak var nextButton: UIButton!
    
    var cancellable = Set<AnyCancellable>()
    var viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindUI()
    }
    
    func bindUI() {

        idTextField.textPublisher
            .assign(to: &viewModel.$idText)
        
        viewModel.$isIdValid.sink { [weak self] (bool) in
            guard let self = self else { return }
            self.idValidLabel.isHidden = bool
        }.store(in: &cancellable)
        
    }
}

extension UITextField {
    var textPublisher: AnyPublisher<String, Never> {
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: self)
            .compactMap { $0.object as? UITextField }
            .map { $0.text ?? "" }
            .eraseToAnyPublisher()
    }
}

