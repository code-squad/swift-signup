import UIKit

class PrivacyViewController: UIViewController {
    
    private var privacyViewTitle: MainTitleLabel!
    private var privacyStackView = PrivacyStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpMainView()
    }
    
    private func setUpMainView() {
        view.backgroundColor = UIColor.systemGray6
        configureTitle()
        configureMainStackView()
        setUpLabelAndTextField()
        setUpSegmentControl()
    }
}

//MARK: -configuration && Setup
extension PrivacyViewController {
    
    private func configureTitle() {
        privacyViewTitle = MainTitleLabel(frame: CGRect(x: 125, y: 60, width: 150, height: 40))
        privacyViewTitle.text = MainTitleContents.privacy
        view.addSubview(privacyViewTitle)
    }
    private func configureMainStackView() {
        privacyStackView.frame = CGRect(x: 40, y: 120, width: 300, height: 400)
        view.addSubview(privacyStackView)
    }
    
    private func setUpLabelAndTextField() {
        privacyStackView.birthdayInfo.infoLabel.text = PrivacyLabelContents.birthday
        privacyStackView.emailInfo.infoLabel.text = PrivacyLabelContents.email
        privacyStackView.cellPhoneInfo.infoLabel.text = PrivacyLabelContents.cellPhone
        privacyStackView.cellPhoneInfo.inputTextField.placeholder = PrivacyLabelContents.cellPhonePlaceholder
    }
    
    private func setUpSegmentControl() {
        privacyStackView.genderInfo.infoLabel.text = PrivacyLabelContents.gender
        privacyStackView.genderInfo.segmentControlInfo.addTarget(self, action: #selector(selectGenderInfo), for: .valueChanged)
    }
}

//MARK: -@objc Action
extension PrivacyViewController {
    
    @objc func selectGenderInfo() {
        //성별정보 저장구현 예정
    }
}

//MARK: -Regex

extension PrivacyViewController {
    
    // Button State Check
    private func enableCheckforButtion() -> Bool {
        return isValidConditionForBithday() && isValidConditionForPassword() && isValidConditionForPasswordConfirm() && isValidConditionForName()
    }
    
    // ID Check
    private func isValidConditionForBithday() -> Bool {
        let userBirthdayView = privacyStackView.birthdayInfo
        
        return false
    }
    
    // Password Check
    private func isValidConditionForPassword() -> Bool {
        let userPasswordView = mainStackView.infoPasswordView
        if validateManager.isEmptyTextField(userPasswordView.inputTextField.text) {
            mainStackView.defaultStateFor(textField: userPasswordView.inputTextField, label: userPasswordView.checkLabel)
        } else if !validateManager.isValidElementForPassword(userPasswordView.inputTextField.text) {
            mainStackView.invalidElementPasswordFor(checkLabel: userPasswordView.checkLabel)
            mainStackView.invalidTextFieldBoarder(textField: userPasswordView.inputTextField)
        } else if !validateManager.isValidCountForPassWord(userPasswordView.inputTextField.text) {
            mainStackView.invalidCountPasswordFor(checkLabel: userPasswordView.checkLabel)
            mainStackView.invalidTextFieldBoarder(textField: userPasswordView.inputTextField)
        } else {
            mainStackView.validPasswordStateFor(checkLabel: userPasswordView.checkLabel)
            mainStackView.validTextFieldBoarder(textField: userPasswordView.inputTextField)
            return true
        }
        return false
    }
    
    // PasswordConfirm Check
    private func isValidConditionForPasswordConfirm() -> Bool {
        let userPasswordConfirmView = mainStackView.doubleCheckPassWordView
        let userPasswordView = mainStackView.infoPasswordView
        if validateManager.isEmptyTextField(userPasswordConfirmView.inputTextField.text) {
            mainStackView.defaultStateFor(textField: userPasswordConfirmView.inputTextField, label: userPasswordConfirmView.checkLabel)
        } else if !validateManager.isEqualForPassword(userPasswordView.inputTextField.text, userPasswordConfirmView.inputTextField.text) {
            mainStackView.incorrectPasswordFor(checkLabel: userPasswordConfirmView.checkLabel)
            mainStackView.invalidTextFieldBoarder(textField: userPasswordConfirmView.inputTextField)
        } else {
            mainStackView.correctPasswordFor(checkLabel: userPasswordConfirmView.checkLabel)
            mainStackView.validTextFieldBoarder(textField: userPasswordConfirmView.inputTextField)
            return true
        }
        return false
    }
    
    // Name Check
    private func isValidConditionForName() -> Bool {
        let userNameView = mainStackView.nameCheckView
        if validateManager.isEmptyTextField(userNameView.inputTextField.text) {
            mainStackView.defaultStateFor(textField: userNameView.inputTextField, label: userNameView.checkLabel)
        } else if !validateManager.isValidNameCount(userNameView.inputTextField.text) {
            mainStackView.invalidNameCountFor(checkLabel: userNameView.checkLabel)
            mainStackView.invalidTextFieldBoarder(textField: userNameView.inputTextField)
        } else {
            mainStackView.validNameStateFor(checkLabel: userNameView.checkLabel)
            mainStackView.validTextFieldBoarder(textField: userNameView.inputTextField)
            return true
        }
        return false
    }
}
