import UIKit

class MoveToNextPage: UIButton {
    
    enum buttonState {
        case on
        case off
    }
    
    var isOn: buttonState = .off {
        didSet {
            enableButton()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureButton()
    }
    
    private func configureButton() {
        setTitle("다음", for: .normal)
        setTitleColor(.systemGray, for: .normal)
        backgroundColor = UIColor.white
        addTarget(superview, action: #selector(SignUpMainViewController.nextMoveButtonTouched(button:)), for: .touchUpInside)
    }
    
    private func enableButton() {
        switch isOn {
        case .off:
            setTitleColor(.systemGray, for: .normal)
            isEnabled = false
        case .on:
            setTitleColor(.systemGreen, for: .normal)
            isEnabled = true
        }
    }
}
