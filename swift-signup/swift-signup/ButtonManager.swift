
import Foundation
import UIKit

class ButtonManager {
    private var states : [ObjectIdentifier:CustomTextField.State]
    private var activeButton : Bool
    
    init() {
        self.states = [:]
        self.activeButton = false
        allElementsStateValid()
    }
    
    func update(textField: CustomTextField.Type, state: CustomTextField.State) {
        self.states.updateValue(state, forKey: ObjectIdentifier(textField))
        allElementsStateValid()
    }
    
    func allElementsStateValid() {
        for ( _, state) in self.states {
            if state != .end && state != .valid {
                self.activeButton = false
                break
            }
            self.activeButton = true
        }
        
        NotificationCenter.default.post(name: ButtonManager.buttonState, object: self, userInfo: [ButtonManager.Info.state : self.activeButton])
    }
}

extension ButtonManager {
    enum Info {
        case state
    }
    
    static let buttonState = Notification.Name("buttonState")
}
