import UIKit

class SignUpMainViewController: UIViewController {
    
    private var mainViewTitle: MainTitleLabel!
    private var mainStackView = MainInfoStackView()
    private var buttonForMove = NextVCButton(type: .system)
    private let delegate = TextFieldDelegate()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpMainView()
        enableButton()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    
    private func setUpMainView() {
        //MainView Background Color
        view.backgroundColor = UIColor.systemGray6
        
        setUpLabelAndTextField()
        
        setUpTextFieldDelegate()
        
        configureTitle()
        
        configureMainStackView()
        
        configureNextButton()
        
        addTargetForButton()
        
        textEdittingForTextField()
        
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
        mainViewTitle = MainTitleLabel(frame: CGRect(x: 125, y: 60, width: 150, height: 40))
        mainViewTitle.text = "회원가입"
        view.addSubview(mainViewTitle)
    }
    
    private func configureMainStackView() {
        mainStackView.frame = CGRect(x: 40, y: 120, width: 300, height: 400)
        view.addSubview(mainStackView)
    }
    
    private func configureNextButton() {
        buttonForMove.frame = CGRect(x: 120, y: 600, width: 140, height: 50)
        view.addSubview(buttonForMove)
    }
    
    private func setUpLabelAndTextField() {
        mainStackView.infoIDView.infoLabel.text = LabelContetns.idLabel.description
        mainStackView.infoIDView.inputTextField.placeholder = LabelContetns.idPlaceholder.description
        mainStackView.infoPasswordView.infoLabel.text = LabelContetns.passwordLabel.description
        mainStackView.infoPasswordView.inputTextField.placeholder = LabelContetns.passwordPlaceHolder.description
        mainStackView.doubleCheckPassWordView.infoLabel.text = LabelContetns.passwordDoubleCheckLabel.description
        mainStackView.nameCheckView.infoLabel.text = LabelContetns.nameLabel.description
    }
    
    private func setUpTextFieldDelegate() {
        mainStackView.infoIDView.inputTextField.delegate = delegate
        mainStackView.infoPasswordView.inputTextField.delegate = delegate
        mainStackView.doubleCheckPassWordView.inputTextField.delegate = delegate
        mainStackView.nameCheckView.inputTextField.delegate = delegate
    }
}

//MARK:: -@objc Action

extension SignUpMainViewController {
    
    @objc func nextMoveButtonTouched(button: UIButton) {
        let privacyController = PrivacyViewController()
        privacyController.modalPresentationStyle = .fullScreen
        present(privacyController, animated: true, completion: nil)
    }
    
    @objc func textFieldEddtingChanged(textField: UITextField) {
        enableButton()
    }
}

//MARK: -Add Target
extension SignUpMainViewController {
    
    private func addTargetForButton() {
        buttonForMove.addTarget(self, action: #selector(nextMoveButtonTouched(button:)), for: .touchUpInside)
    }

    private func textEdittingForTextField() {
        mainStackView.infoIDView.inputTextField.addTarget(self, action: #selector(textFieldEddtingChanged(textField:)), for: .editingChanged)
        mainStackView.infoPasswordView.inputTextField.addTarget(self, action: #selector(textFieldEddtingChanged(textField:)), for: .editingChanged)
        mainStackView.doubleCheckPassWordView.inputTextField.addTarget(self, action: #selector(textFieldEddtingChanged(textField:)), for: .editingChanged)
        mainStackView.nameCheckView.inputTextField.addTarget(self, action: #selector(textFieldEddtingChanged(textField:)), for: .editingChanged)
    }
}
