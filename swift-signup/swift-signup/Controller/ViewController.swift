
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var nextButton: UIButton!
    private var buttonManager = ButtonManager()
    
    @IBOutlet weak var idTextField: UITextField!
    private var idTextFieldDelegate = IdTextFieldDelegate()
    @IBOutlet weak var idLabel: UILabel!
    
    @IBOutlet weak var passwordTextField: UITextField!
    private var passwordTextFieldDelegate = PasswordTextFieldDelegate()
    @IBOutlet weak var passwordLabel: UILabel!

    @IBOutlet weak var passwordConfirmTextField: UITextField!
    private var passwordConfirmTextFieldDelegate = PasswordConfirmTextFieldDelegate()
    @IBOutlet weak var passwordConfirmLabel: UILabel!

    @IBOutlet weak var nameTextField: UITextField!
    private var nameTextFieldDelegate = NameTextFieldDelegate()
    @IBOutlet weak var nameLabel: UILabel!

    //MARK: 새로운 구조
    private var validater = Validater()
    private var idTextFieldDelegate2 = CustomTextFieldDelegate()
    private var passwordTextFieldDelegate2 = CustomTextFieldDelegate()
    private var passwordConfirmTextFieldDelegate2 = CustomTextFieldDelegate()
    private var nameTextFieldDelegate2 = CustomTextFieldDelegate()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        NotificationCenter.default.addObserver(self, selector: #selector(idGuideText), name: Validater.evaluatedIdInformation, object: validater)
        NotificationCenter.default.addObserver(self, selector: #selector(passwordGuideText), name: Validater.evaluatedPasswordInformation, object: validater)
        NotificationCenter.default.addObserver(self, selector: #selector(passwordConfirmGuideText), name: Validater.evaluatedPasswordConfirmInformation, object: validater)
        NotificationCenter.default.addObserver(self, selector: #selector(nameGuideText), name: Validater.evaluatedNameInformation, object: validater)
        NotificationCenter.default.addObserver(self, selector: #selector(buttonState), name: Validater.isButtonValid, object: validater)
//        NotificationCenter.default.addObserver(self, selector: #selector(buttonState), name: ButtonManager.buttonState, object: buttonManager)
        configureDelegate()
        configureTextField()
//        registerDelegate()
//        registerTextField()
//        setUpPasswordTextField()
//        buttonManager.isAllInfoValid()
    }

    //MARK: 새로운 구조들
    func configureDelegate() {
        self.idTextField.delegate = idTextFieldDelegate2
        self.passwordTextField.delegate = passwordTextFieldDelegate2
        self.passwordConfirmTextField.delegate = passwordConfirmTextFieldDelegate2
        self.nameTextField.delegate = nameTextFieldDelegate2
    }
    
    func configureTextField() {
        self.idTextFieldDelegate2.configureText() { text, range, string in
            self.validater.idValidate(text: text, range: range, string: string)
        }
        
        self.passwordTextFieldDelegate2.configureText() { text, range, string in
            self.validater.passwordValidate(text: text, range: range, string: string)
        }
        
        self.passwordConfirmTextFieldDelegate2.configureText() { text, range, string in
            self.validater.passwordConfirmValidate(text: text, range: range, string: string)
        }
        
        self.nameTextFieldDelegate2.configureText() { text, range, string in
            self.validater.nameValidate(text: text, range: range, string: string)
        }
    }
    
    
    
    //MARK: 이전 구조들
//    func registerDelegate() {
//        self.idTextField.delegate = idTextFieldDelegate
//        self.passwordTextField.delegate = passwordTextFieldDelegate
//        self.passwordConfirmTextField.delegate = passwordConfirmTextFieldDelegate
//        self.nameTextField.delegate = nameTextFieldDelegate
//    }
//
//    func registerTextField() {
//        self.buttonManager.register(userInfo: idTextFieldDelegate)
//        self.buttonManager.register(userInfo: passwordTextFieldDelegate)
//        self.buttonManager.register(userInfo: passwordConfirmTextFieldDelegate)
//        self.buttonManager.register(userInfo: nameTextFieldDelegate)
//    }
//
//    func setUpPasswordTextField() {
//        self.passwordTextField.isSecureTextEntry = true
//        self.passwordConfirmTextField.isSecureTextEntry = true
//    }
    
    //MARK: @objc 처리
    @objc
    func idGuideText(notification: Notification) {
        guard let text = notification.userInfo?[Validater.MessageInfo.text] as? String,
              let color = notification.userInfo?[Validater.MessageInfo.color] as? UIColor
        else {
            return
        }
        self.idLabel.text = text
        self.idLabel.textColor = color
        self.idTextField.layer.borderColor = color.cgColor
//        buttonManager.isAllInfoValid()
    }
    
    @objc
    func passwordGuideText(notification: Notification) {
        guard let text = notification.userInfo?[Validater.MessageInfo.text] as? String,
              let color = notification.userInfo?[Validater.MessageInfo.color] as? UIColor
        else {
            return
        }
        self.passwordLabel.text = text
        self.passwordLabel.textColor = color
        self.passwordTextField.layer.borderColor = color.cgColor
//        buttonManager.isAllInfoValid()
    }
    
    @objc
    func passwordConfirmGuideText(notification: Notification) {
        guard let text = notification.userInfo?[Validater.MessageInfo.text] as? String,
              let color = notification.userInfo?[Validater.MessageInfo.color] as? UIColor
        else {
            return
        }
        self.passwordConfirmLabel.text = text
        self.passwordConfirmLabel.textColor = color
        self.passwordConfirmTextField.layer.borderColor = color.cgColor
//        buttonManager.isAllInfoValid()
    }
    
    @objc
    func nameGuideText(notification: Notification) {
        guard let text = notification.userInfo?[Validater.MessageInfo.text] as? String,
              let color = notification.userInfo?[Validater.MessageInfo.color] as? UIColor
        else {
            return
        }
        self.nameLabel.text = text
        self.nameLabel.textColor = color
        self.nameTextField.layer.borderColor = color.cgColor
//        buttonManager.isAllInfoValid()
    }
    
    @objc
    func buttonState(notification: Notification) {
        guard let isValid = notification.userInfo?[Validater.TextStateInfo.isAllValid] as? Bool
        else {
            return
        }
        self.nextButton.isEnabled = isValid
    }
//    @objc
//    func buttonState(notification: Notification) {
//        guard let isActive = notification.userInfo?[ButtonManager.Info.state] as? Bool
//        else {
//            return
//        }
//        self.nextButton.isEnabled = isActive
//    }
    
//    @IBAction func exitIdTextField(_ sender: Any) {
//        self.passwordTextField.becomeFirstResponder()
//        buttonManager.isAllInfoValid()
//    }
//
//
//    @IBAction func exitPasswordTextField(_ sender: Any) {
//        self.passwordConfirmTextField.becomeFirstResponder()
//        buttonManager.isAllInfoValid()
//    }
//
//
//    @IBAction func exitPasswordConfirmTextField(_ sender: Any) {
//        self.nameTextField.becomeFirstResponder()
//        buttonManager.isAllInfoValid()
//    }
//
//    @IBAction func exitNameTextField(_ sender: Any) {
//        self.nameTextField.resignFirstResponder()
//        if self.nextButton.isEnabled, let personnalInformationViewController = self.storyboard?.instantiateViewController(identifier: "PersonnalInformationViewController") {
//            navigationController?.pushViewController(personnalInformationViewController, animated: true)
//        }
//    }
//
    @IBAction func nextButtonPressed(_ sender: Any) {
        self.nameTextField.resignFirstResponder()
        guard let personnalInformationViewController = self.storyboard?.instantiateViewController(identifier: "PersonnalInformationViewController")
        else {
            return
        }
        navigationController?.pushViewController(personnalInformationViewController, animated: true)
    }
}

