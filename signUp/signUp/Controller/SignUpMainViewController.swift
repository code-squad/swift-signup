import UIKit

class SignUpMainViewController: UIViewController {
    
    private var mainViewTitle: MainTitleLabel!
    private var mainStackView = MainInfoStackView()
    private var buttonForMove = MoveToNextPage(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpMainView()
        enableButton()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    private func setUpMainView() {
        //MainView Background Color
        view.backgroundColor = UIColor.systemGray6
        
        configureTitle()
        
        configureMainStackView()
        
        configureNextButton()
    }
    
    private func enableButton() {
        if mainStackView.enableCheckForNextPage() {
            buttonForMove.isOn = .on
        } else {
            buttonForMove.isOn = .off
        }
    }
}


//MARK: -configuration && Setup

extension SignUpMainViewController {
    
    private func configureTitle() {
        mainViewTitle = MainTitleLabel(frame: CGRect(x: 125, y: 60, width: 150, height: 40), title: "회원가입")
        view.addSubview(mainViewTitle)
    }
    
    private func configureMainStackView() {
        view.addSubview(mainStackView)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        mainStackView.heightAnchor.constraint(equalToConstant: 400).isActive = true
        mainStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 120).isActive = true
        mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
    }
    
    private func configureNextButton() {
        view.addSubview(buttonForMove)
        buttonForMove.translatesAutoresizingMaskIntoConstraints = false
        buttonForMove.widthAnchor.constraint(equalToConstant: 140).isActive = true
        buttonForMove.heightAnchor.constraint(equalToConstant: 50).isActive = true
        buttonForMove.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 120).isActive = true
        buttonForMove.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200).isActive = true
    }
}

//MARK:: -@objc Action

extension SignUpMainViewController {
    
    @objc func textFieldTouched(textField: UITextField) {
        textField.text = ""
    }
    
    @objc func nextMoveButtonTouched(button: UIButton) {
        let privacyController = PrivacyViewController()
        privacyController.modalPresentationStyle = .fullScreen
        present(privacyController, animated: true, completion: nil)
    }
    
    @objc func textFieldEddtingChanged(textField: UITextField) {
        enableButton()
    }
}
