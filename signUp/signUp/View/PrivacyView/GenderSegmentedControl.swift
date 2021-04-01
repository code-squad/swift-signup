import UIKit

class GenderSegmentedControl: UISegmentedControl {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override init(items: [Any]?) {
        super.init(items: items)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configureSegmentControl() {
        backgroundColor = UIColor.white
    }
}
