import UIKit

class PrivacyStackView: UIStackView {
    
    var birthdayInfo = EachInfoView()
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
        self.addArrangedSubview(emailInfo)
        self.addArrangedSubview(cellPhoneInfo)
    }
}
