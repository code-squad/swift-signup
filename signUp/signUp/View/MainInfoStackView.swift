import UIKit

class MainInfoStackView: UIStackView {
    
    var infoIDView = EachInfoView()
    var infoPasswordView = EachInfoView()
    var doubleCheckPassWordView = EachInfoView()
    var nameCheckView = EachInfoView()
    private var idList = [String]()
    
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
        NetworkHandler.getData { serverIdList in
            self.idList = serverIdList
        }
        self.addArrangedSubview(infoIDView)
        self.addArrangedSubview(infoPasswordView)
        self.addArrangedSubview(doubleCheckPassWordView)
        self.addArrangedSubview(nameCheckView)
    }
}

//MARK: -Condition & Regex
extension MainInfoStackView {
    
    func enableCheckForNextPage() -> Bool {
        return conditionForID() && conditionForPassWord() && conditionForPasswordConfirm() && conditionForName()
    }
    
    func conditionForID() -> Bool {
        if infoIDView.inputTextField.text?.count == 0 {
            infoIDView.checkLabel.text = ""
        } else if !doubleCheckID(infoIDView.inputTextField.text ){
            infoIDView.inputTextField.layer.borderColor = UIColor.red.cgColor
            infoIDView.checkLabel.textColor = UIColor.red
            infoIDView.checkLabel.text = IdCheck.doubleCheck.description
        }else if !checkValidElementForID(infoIDView.inputTextField.text) {
            infoIDView.checkLabel.text = IdCheck.nonSupportedValue.description
            infoIDView.inputTextField.layer.borderColor = UIColor.red.cgColor
            infoIDView.checkLabel.textColor = UIColor.red
        } else if !checkValidCountForID(infoIDView.inputTextField.text) {
            infoIDView.checkLabel.text = IdCheck.idCount.description
            infoIDView.inputTextField.layer.borderColor = UIColor.red.cgColor
            infoIDView.checkLabel.textColor = UIColor.red
        } else {
            infoIDView.inputTextField.layer.borderWidth = 0
            infoIDView.checkLabel.text = IdCheck.valid.description
            infoIDView.checkLabel.textColor = UIColor.systemGreen
            return true
        }
        return false
    }
    
    func conditionForPassWord() -> Bool {
        if infoPasswordView.inputTextField.text?.count == 0 {
            infoPasswordView.checkLabel.text = ""
        } else if !checkValidPasswordElement(infoPasswordView.inputTextField.text) {
            infoPasswordView.checkLabel.text = PasswordCheck.notContainedSpecialCharacters.description
            infoPasswordView.checkLabel.textColor = UIColor.red
            infoPasswordView.inputTextField.layer.borderColor = UIColor.red.cgColor
        } else if !checkValidCountForPassWord(infoPasswordView.inputTextField.text) {
            infoPasswordView.checkLabel.text = PasswordCheck.passwordCount.description
            infoPasswordView.checkLabel.textColor = UIColor.red
            infoPasswordView.inputTextField.layer.borderColor = UIColor.red.cgColor
        } else {
            infoPasswordView.inputTextField.layer.borderWidth = 0
            infoPasswordView.checkLabel.text = PasswordCheck.valid.description
            infoPasswordView.checkLabel.textColor = UIColor.systemGreen
            return true
        }
        return  false
    }
    
    func conditionForPasswordConfirm() -> Bool {
        if doubleCheckPassWordView.inputTextField.text?.count == 0 {
            doubleCheckPassWordView.inputTextField.layer.borderWidth = 0
            doubleCheckPassWordView.checkLabel.text = ""
        } else if infoPasswordView.inputTextField.text != doubleCheckPassWordView.inputTextField.text {
            doubleCheckPassWordView.inputTextField.layer.borderColor = UIColor.red.cgColor
            doubleCheckPassWordView.checkLabel.textColor = UIColor.red
            doubleCheckPassWordView.checkLabel.text = PasswordConfirmCheck.notEqul.description
        } else {
            doubleCheckPassWordView.inputTextField.layer.borderWidth = 0
            doubleCheckPassWordView.checkLabel.text = PasswordConfirmCheck.valid.description
            doubleCheckPassWordView.checkLabel.textColor = UIColor.systemGreen
            return true
        }
        return false
    }
    
    func conditionForName() -> Bool {
        if nameCheckView.inputTextField.text?.count == 0 {
            nameCheckView.inputTextField.layer.borderWidth = 0
            nameCheckView.checkLabel.text = ""
        } else if !checkValidNameCount(nameCheckView.inputTextField.text) {
            nameCheckView.inputTextField.layer.borderColor = UIColor.red.cgColor
            nameCheckView.checkLabel.textColor = UIColor.red
            nameCheckView.checkLabel.text = NameCheck.nameCount.description
        } else {
            nameCheckView.inputTextField.layer.borderWidth = 0
            nameCheckView.checkLabel.text = NameCheck.valid.description
            nameCheckView.checkLabel.textColor = UIColor.systemGreen
            return true
        }
        return false
    }
    
    func checkValidCountForID(_ id: String?) -> Bool {
        let idCount = id?.getArrayAfterRegex(regex: "[a-z0-9_-]").count ?? 0
        return idCount>=5 && idCount<=20
    }
    
    func doubleCheckID(_ id: String?) -> Bool {
        if let userID = id {
            if !idList.contains(userID) {
                return true
            }
        }
        return false
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
