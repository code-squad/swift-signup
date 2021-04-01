import UIKit

class PrivacyStackView: UIStackView {
    
    var birthdayInfo = EachInfoView()
    var emailInfo = EachInfoView()
    var cellPhoneInfo = EachInfoView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpPrivacyStackView()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setUpPrivacyStackView()
    }
    
    private func setUpPrivacyStackView() {
        axis = .vertical
        spacing = 10
    }
}
