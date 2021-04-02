import UIKit

class GenderSegmentedControl: UISegmentedControl {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSegmentControl()
    }
    
    override init(items: [Any]?) {
        super.init(items: items)
        configureSegmentControl()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureSegmentControl()
    }
    
    private func configureSegmentControl() {
        tintColor = UIColor.white
        selectedSegmentIndex = 0
    }
}
