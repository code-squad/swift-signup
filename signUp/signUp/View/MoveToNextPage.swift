import UIKit

class MoveToNextPage: UIButton {
    
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
        setTitleColor(.systemGreen, for: .normal)
        backgroundColor = UIColor.white
        addTarget(superview, action: #selector(SignUpMainViewController.nextMoveButtonTouched(button:)), for: .touchUpInside)
    }
}
