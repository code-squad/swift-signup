import UIKit

class PrivacyStackView: UIStackView {
    
    var birthdayInfo = EachInfoView()
    var genderInfo = LabelSegmentView()
    var emailInfo = EachInfoView()
    var cellPhoneInfo = EachInfoView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpPrivacyStackView()
        setUpSubViews()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setUpPrivacyStackView()
        setUpSubViews()
    }
    
    private func setUpPrivacyStackView() {
        axis = .vertical
        spacing = 10
    }
    
    private func setUpSubViews() {
        self.addArrangedSubview(birthdayInfo)
        self.addArrangedSubview(genderInfo)
        self.addArrangedSubview(emailInfo)
        self.addArrangedSubview(cellPhoneInfo)
    }
}

extension PrivacyStackView {
    
    // Common Method
    func defaultStateFor(textField: UITextField, label: UILabel) {
        textField.layer.borderWidth = 0
        label.text = ""
    }
    
    func invalidTextFieldBoarder(textField: UITextField) {
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.red.cgColor
    }
    
    func validTextFieldBoarder(textField: UITextField) {
        textField.layer.borderWidth = 0
    }
    
    // Email Method
    func inValidEmailFor(checkLabel: UILabel) {
        checkLabel.textColor = UIColor.systemRed
        checkLabel.text = EmailCheck.inValid
    }
    func validEmailFor(checkLabel: UILabel) {
        checkLabel.textColor = UIColor.systemGreen
        checkLabel.text = IdCheck.valid
    }
}
