
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var idLabel: UILabel!
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!

    @IBOutlet weak var passwordConfirmTextField: UITextField!
    @IBOutlet weak var passwordConfirmLabel: UILabel!

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var nameLabel: UILabel!

    private var validater = Validater()
    private var idTextFieldDelegate = CustomTextFieldDelegate()
    private var passwordTextFieldDelegate = CustomTextFieldDelegate()
    private var passwordConfirmTextFieldDelegate = CustomTextFieldDelegate()
    private var nameTextFieldDelegate = CustomTextFieldDelegate()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        NotificationCenter.default.addObserver(self, selector: #selector(idGuideText), name: Validater.evaluatedIdInformation, object: validater)
        NotificationCenter.default.addObserver(self, selector: #selector(passwordGuideText), name: Validater.evaluatedPasswordInformation, object: validater)
        NotificationCenter.default.addObserver(self, selector: #selector(passwordConfirmGuideText), name: Validater.evaluatedPasswordConfirmInformation, object: validater)
        NotificationCenter.default.addObserver(self, selector: #selector(nameGuideText), name: Validater.evaluatedNameInformation, object: validater)
        NotificationCenter.default.addObserver(self, selector: #selector(buttonState), name: Validater.isButtonValid, object: validater)
        
        configureDelegate()
        configureTextField()
    }
    
    //MARK: configure
    func configureDelegate() {
        self.idTextField.delegate = idTextFieldDelegate
        self.passwordTextField.delegate = passwordTextFieldDelegate
        self.passwordConfirmTextField.delegate = passwordConfirmTextFieldDelegate
        self.nameTextField.delegate = nameTextFieldDelegate
    }
    
    func configureTextField() {
        self.idTextFieldDelegate.configureText() { text, range, string in
            self.validater.idValidate(text: text, range: range, string: string)
        }
        
        self.passwordTextFieldDelegate.configureText() { text, range, string in
            self.validater.passwordValidate(text: text, range: range, string: string)
        }
        
        self.passwordConfirmTextFieldDelegate.configureText() { text, range, string in
            self.validater.passwordConfirmValidate(text: text, range: range, string: string)
        }
        
        self.nameTextFieldDelegate.configureText() { text, range, string in
            self.validater.nameValidate(text: text, range: range, string: string)
        }
    }
    
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
    }
    
    @objc
    func buttonState(notification: Notification) {
        guard let isValid = notification.userInfo?[Validater.TextStateInfo.isAllValid] as? Bool
        else {
            return
        }
        self.nextButton.isEnabled = isValid
    }
    
    //MARK: Responder 처리
    @IBAction func exitIdTextField(_ sender: Any) {
        self.passwordTextField.becomeFirstResponder()
    }


    @IBAction func exitPasswordTextField(_ sender: Any) {
        self.passwordConfirmTextField.becomeFirstResponder()
    }


    @IBAction func exitPasswordConfirmTextField(_ sender: Any) {
        self.nameTextField.becomeFirstResponder()
    }

    @IBAction func exitNameTextField(_ sender: Any) {
        self.nameTextField.resignFirstResponder()
        if self.nextButton.isEnabled, let personnalInformationViewController = self.storyboard?.instantiateViewController(identifier: "PersonnalInformationViewController") {
            navigationController?.pushViewController(personnalInformationViewController, animated: true)
        }
    }

    @IBAction func nextButtonPressed(_ sender: Any) {
        self.nameTextField.resignFirstResponder()
        guard let personnalInformationViewController = self.storyboard?.instantiateViewController(identifier: "PersonnalInformationViewController")
        else {
            return
        }
        navigationController?.pushViewController(personnalInformationViewController, animated: true)
    }
}

