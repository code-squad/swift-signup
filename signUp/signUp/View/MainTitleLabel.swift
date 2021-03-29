import Foundation
import UIKit

class MainTitleLabel: UILabel {
    
    var titleInfo: String!
    
    init(frame: CGRect, title: String) {
        super.init(frame: frame)
        titleInfo = title
        configureSelfLabel()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureSelfLabel()
    }
    
    private func configureSelfLabel() {
        let fontSize = UIFont.boldSystemFont(ofSize: 40)
        let attributedString = NSMutableAttributedString(string: titleInfo)
        attributedString.addAttribute(.font, value: fontSize, range: NSRange(location: 0, length: titleInfo.count))
        attributedText = attributedString
        textAlignment = .center
        textColor = UIColor.systemGreen
    }
}
