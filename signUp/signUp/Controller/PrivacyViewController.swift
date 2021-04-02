import UIKit

class PrivacyViewController: UIViewController {
    
    private var privacyViewTitle: MainTitleLabel!
    private var privacyStackView = PrivacyStackView()
    private let validateManager = RegexValidManager()
    private var datePicker = UIDatePicker()
    private var buttonForNext = CustomButton(type: .system)
    private var buttonForBack = CustomButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpMainView()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    
    private func setUpMainView() {
        view.backgroundColor = UIColor.systemGray6
        configureTitle()
        configureMainStackView()
        setUpLabelAndTextField()
        setUpSegmentControl()
        textEdittingForTextField()
        setDatePicker()
        configureNextButton()
    }
    
    private func enableButton() {
        if enableCheckforButtion() {
            buttonForNext.isOn = .on
        } else {
            buttonForNext.isOn = .off
        }
    }
}

//MARK: -configuration && Setup
extension PrivacyViewController {
    
    private func configureTitle() {
        privacyViewTitle = MainTitleLabel(frame: CGRect(x: 0, y: 0, width: 150, height: 40))
        privacyViewTitle.layer.position = CGPoint(x: view.bounds.width/2, y: 60)
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
        privacyStackView.emailInfo.inputTextField.keyboardType = .emailAddress
        privacyStackView.cellPhoneInfo.infoLabel.text = PrivacyLabelContents.cellPhone
        privacyStackView.cellPhoneInfo.inputTextField.placeholder = PrivacyLabelContents.cellPhonePlaceholder
        privacyStackView.cellPhoneInfo.inputTextField.keyboardType = .numberPad
    }
    
    private func setUpSegmentControl() {
        privacyStackView.genderInfo.infoLabel.text = PrivacyLabelContents.gender
        privacyStackView.genderInfo.segmentControlInfo.addTarget(self, action: #selector(selectGenderInfo), for: .valueChanged)
    }
    
    private func setDatePicker() {
        let birthdayTextField = privacyStackView.birthdayInfo.inputTextField
        datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: 300, height: 400))
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.maximumDate = DateFormatManager.setUpMaxDateRagne()
        datePicker.minimumDate = DateFormatManager.setUpMinDateRange()
        birthdayTextField.inputView = datePicker

        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 300, height: 50))
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: #selector(datePickerCancelled))
        let done = UIBarButtonItem(title: "Done", style: .plain, target: nil, action: #selector(datePickerSelected))
        toolBar.setItems([cancel, flexible, done], animated: false)
        birthdayTextField.inputAccessoryView = toolBar
    }
    
    private func configureNextButton() {
        buttonForNext.frame = CGRect(x: 200, y: 600, width: 140, height: 50)
        buttonForBack.frame = CGRect(x: 50, y: 600, width: 140, height: 50)
        buttonForBack.setTitle("이전", for: .normal)
        buttonForBack.isOn = .on
        view.addSubview(buttonForNext)
        view.addSubview(buttonForBack)
    }
}

//MARK: -@objc Action
extension PrivacyViewController {
    
    @objc func selectGenderInfo() {
        //성별정보 저장구현 예정
    }
    @objc func textFieldEddtingChanged(textField: UITextField) {
        enableButton()
        let _ = isValidStateForBirthday() || isValidStateForEmail() || isValidStateForPhone()
    }
    @objc func datePickerCancelled() {
        privacyStackView.birthdayInfo.inputTextField.resignFirstResponder()
    }
    @objc func datePickerSelected() {
        privacyStackView.birthdayInfo.inputTextField.text = DateFormatManager.formatDateToString(datePicker.date)
        view.endEditing(true)
    }
}

//MARK: -@Add Target
extension PrivacyViewController {
    private func textEdittingForTextField() {
        privacyStackView.birthdayInfo.inputTextField.addTarget(self, action: #selector(textFieldEddtingChanged(textField:)), for: .editingChanged)
        privacyStackView.emailInfo.inputTextField.addTarget(self, action: #selector(textFieldEddtingChanged(textField:)), for: .editingChanged)
        privacyStackView.cellPhoneInfo.inputTextField.addTarget(self, action: #selector(textFieldEddtingChanged(textField:)), for: .editingChanged)
    }
}

//MARK: -Regex

extension PrivacyViewController {
    
    private func enableCheckforButtion() -> Bool {
        return  isValidStateForBirthday() && isValidStateForEmail() && isValidStateForPhone()
    }
    
    private func isValidStateForBirthday() -> Bool {
        let birthday = privacyStackView.birthdayInfo
        if !validateManager.isEmptyTextField(birthday.inputTextField.text) {
            return true
        }
        return false
    }
    
    private func isValidStateForEmail()  -> Bool {
        let email = privacyStackView.emailInfo
        if validateManager.isEmptyTextField(email.inputTextField.text) {
            privacyStackView.defaultStateFor(textField: email.inputTextField, label: email.checkLabel)
        } else if !validateManager.isValidStateForEmail(email.inputTextField.text) {
            privacyStackView.invalidTextFieldBoarder(textField: email.inputTextField)
            privacyStackView.inValidEmailFor(checkLabel: email.checkLabel)
        } else {
            privacyStackView.validTextFieldBoarder(textField: email.inputTextField)
            privacyStackView.validEmailFor(checkLabel: email.checkLabel)
            return true
        }
        return false
    }
    
    private func isValidStateForPhone() -> Bool {
        let phone = privacyStackView.cellPhoneInfo
        if validateManager.isEmptyTextField(phone.inputTextField.text) {
            privacyStackView.defaultStateFor(textField: phone.inputTextField, label: phone.checkLabel)
        } else if !validateManager.isValidStateForPhone(phone.inputTextField.text) {
            privacyStackView.invalidTextFieldBoarder(textField: phone.inputTextField)
            privacyStackView.inValidPhoneFor(checkLabel: phone.checkLabel)
        } else {
            privacyStackView.validTextFieldBoarder(textField: phone.inputTextField)
            privacyStackView.validPhoneFor(checkLabel: phone.checkLabel)
            return true
        }
        return false
    }
    
}
