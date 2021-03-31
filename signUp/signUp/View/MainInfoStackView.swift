import UIKit

class MainInfoStackView: UIStackView {
    
    private(set) var infoIDView = EachInfoView()
    private(set) var infoPasswordView = EachInfoView()
    private(set) var dobleCheckPassWordView = EachInfoView()
    private(set) var nameCheckView = EachInfoView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpMainStackView()
        setUpSubViews()
    }
    
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setUpMainStackView()
        setUpSubViews()
    }
    
    private func setUpMainStackView() {
        axis = .vertical
        spacing = 10
    }
    
    private func setUpSubViews() {
        setUpIDInfoView()
        setUpPassWordInfoView()
        setUpDoubleCheckInfoView()
        setUpnameCheckInfoView()
        infoIDView.inputTextField.delegate = self
        infoPasswordView.inputTextField.delegate = self
        dobleCheckPassWordView.inputTextField.delegate = self
        nameCheckView.inputTextField.delegate = self
    }
}

//MARK: -setUp Elements Of StackView
extension MainInfoStackView {
    
    private func setUpIDInfoView() {
        infoIDView.infoLabel.text = "아이디"
        infoIDView.inputTextField.attributedPlaceholder = NSAttributedString(string: " 영문 소문자, 숫자, 특수기호(_,-), 5~20자")
        self.addArrangedSubview(infoIDView)
    }

    private func setUpPassWordInfoView() {
        infoPasswordView.infoLabel.text = "비밀번호"
        infoPasswordView.inputTextField.attributedPlaceholder = NSAttributedString(string: " 영문 대/소문자, 숫자, 특수기호(!@#$%), 8~16자")
        self.addArrangedSubview(infoPasswordView)
    }

    private func setUpDoubleCheckInfoView() {
        dobleCheckPassWordView.infoLabel.text = "비밀번호 재확인"
        self.addArrangedSubview(dobleCheckPassWordView)
    }
    
    private func setUpnameCheckInfoView() {
        nameCheckView.infoLabel.text = "이름"
        self.addArrangedSubview(nameCheckView)
    }
}

//MARK: -Condition & Regex
extension MainInfoStackView: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        infoIDView.inputTextField.layer.borderWidth = 1.0
        let _ = enableCheckForNextPage()
        return true
    }
    
    func enableCheckForNextPage() -> Bool {
        return conditionForID() && conditionForPassWord() && conditionForName()
    }
    
    func conditionForID() -> Bool {
        if infoIDView.inputTextField.text?.count == 0 {
            infoIDView.checkLabel.text = ""
            return false
        } else if !checkValidElementForID(infoIDView.inputTextField.text) {
            infoIDView.checkLabel.text = IdCheck.nonSupportedValue.description
            infoIDView.inputTextField.layer.borderColor = UIColor.red.cgColor
            infoIDView.checkLabel.textColor = UIColor.red
            return false
        } else if !checkValidCountForID(infoIDView.inputTextField.text) {
            infoIDView.checkLabel.text = IdCheck.idCount.description
            infoIDView.inputTextField.layer.borderColor = UIColor.red.cgColor
            infoIDView.checkLabel.textColor = UIColor.red
            return false
        } else {
            infoIDView.inputTextField.layer.borderWidth = 0
            infoIDView.checkLabel.text = IdCheck.valid.description
            infoIDView.checkLabel.textColor = UIColor.systemGreen
            return true
        }
    }
    
    func conditionForPassWord() -> Bool {
        let password = infoPasswordView.inputTextField.text ?? "a"
        let passwordCheck = dobleCheckPassWordView.inputTextField.text ?? "b"
        return password==passwordCheck && checkValidPasswordElement(password) && checkValidCountForPassWord(password)
    }
    
    func conditionForName() -> Bool {
        return checkValidNameCount(nameCheckView.inputTextField.text)
    }
    
    func checkValidCountForID(_ id: String?) -> Bool {
        let idCount = id?.getArrayAfterRegex(regex: "[a-z0-9_-]").count ?? 0
        return idCount>=5 && idCount<=20
    }
    
    func checkValidElementForID(_ id: String?) -> Bool {
        let idElement = id?.getArrayAfterRegex(regex: "[A-Z!@#$%]").count ?? 0
        return idElement == 0
    }
    
    func checkValidCountForPassWord(_ password: String?) -> Bool {
        let passCount = password?.getArrayAfterRegex(regex: "[a-zA-Z0-9!@#$%]").count ?? 0
        return passCount >= 8 && passCount <= 16
    }
    
    func checkValidPasswordElement(_ password: String?) -> Bool {
        let element = password?.getArrayAfterRegex(regex: "[!@#$%]").count ?? 0
        return element >= 1
    }
    
    func checkValidNameCount(_ name: String?) -> Bool {
        let nameTest = name?.getArrayAfterRegex(regex: "[가-힣]").count ?? 0
        return nameTest >= 2
    }
}
