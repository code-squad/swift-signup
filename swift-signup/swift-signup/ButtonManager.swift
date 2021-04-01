
import Foundation
import UIKit

class ButtonManager {
    private var userInfo : [UserInfoValidable]
    private var isButtonUsable : Bool
    
    init() {
        self.userInfo = []
        self.isButtonUsable = false
        isAllInfoValid()
    }
    
    func register(userInfo: UserInfoValidable) {
        self.userInfo.append(userInfo)
    }
    
    func isAllInfoValid() {
        if self.userInfo.filter({ $0.isUserInfoValid() == false }).count > 0 {
            self.isButtonUsable = false
        } else {
            self.isButtonUsable = true
        }
        
        NotificationCenter.default.post(name: ButtonManager.buttonState, object: self, userInfo: [ButtonManager.Info.state : self.isButtonUsable])
    }
}

extension ButtonManager {
    enum Info {
        case state
    }
    
    static let buttonState = Notification.Name("buttonState")
}
