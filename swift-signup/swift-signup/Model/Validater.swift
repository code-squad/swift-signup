
import Foundation
import UIKit

class Validater {
    private var idValidater: IdValidater2
    private var passwordValidater: PasswordValidater2
    private var passwordConfirmValidater: PasswordConfirmValidater2
    private var nameValidater: NameValidater2
    
    init() {
        self.idValidater = IdValidater2()
        self.passwordValidater = PasswordValidater2()
        self.passwordConfirmValidater = PasswordConfirmValidater2()
        self.nameValidater = NameValidater2()
    }
    
    func combineText(text: String, range: NSRange, string: String) -> String {
        let newText = text as NSString
        return newText.replacingCharacters(in: range, with: string)
    }
    
    func idValidate(text: String, range: NSRange, string: String) {
        let newText = combineText(text: text, range: range, string: string)
        let messageInfo = self.idValidater.evaluate(with: newText)
        NotificationCenter.default.post(name: Validater.evaluatedIdInformation, object: self, userInfo: messageInfo)
    }
    
    func passwordValidate(text: String, range: NSRange, string: String) {
        let newText = combineText(text: text, range: range, string: string)
        self.passwordConfirmValidater.update(password: newText)
        let messageInfo = self.passwordValidater.evaluate(with: newText)
        NotificationCenter.default.post(name: Validater.evaluatedPasswordInformation, object: self, userInfo: messageInfo)
    }
    
    func passwordConfirmValidate(text: String, range: NSRange, string: String) {
        let newText = combineText(text: text, range: range, string: string)
        let messageInfo = self.passwordConfirmValidater.evaluate(with: newText)
        NotificationCenter.default.post(name: Validater.evaluatedPasswordConfirmInformation, object: self, userInfo: messageInfo)
    }
    
    func nameValidate(text: String, range: NSRange, string: String) {
        let newText = combineText(text: text, range: range, string: string)
        let messageInfo = self.nameValidater.evaluate(with: newText)
        NotificationCenter.default.post(name: Validater.evaluatedNameInformation, object: self, userInfo: messageInfo)
    }
    
}

extension Validater {
    
    enum MessageInfo {
        case text
        case color
    }
    
    static let evaluatedIdInformation = Notification.Name("valiatedIdInformation")
    static let evaluatedPasswordInformation = Notification.Name("evaluatedPasswordInformation")
    static let evaluatedPasswordConfirmInformation = Notification.Name("evaluatedPasswordConfirmInformation")
    static let evaluatedNameInformation = Notification.Name("evaluatedNameInformation")

}


