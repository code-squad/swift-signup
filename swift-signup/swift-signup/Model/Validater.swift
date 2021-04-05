
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
        buttonValidate()
    }
    
    func passwordValidate(text: String, range: NSRange, string: String) {
        let newText = combineText(text: text, range: range, string: string)
        self.passwordConfirmValidater.update(password: newText)
        let messageInfo = self.passwordValidater.evaluate(with: newText)
        NotificationCenter.default.post(name: Validater.evaluatedPasswordInformation, object: self, userInfo: messageInfo)
        buttonValidate()
    }
    
    func passwordConfirmValidate(text: String, range: NSRange, string: String) {
        let newText = combineText(text: text, range: range, string: string)
        let messageInfo = self.passwordConfirmValidater.evaluate(with: newText)
        NotificationCenter.default.post(name: Validater.evaluatedPasswordConfirmInformation, object: self, userInfo: messageInfo)
        buttonValidate()
    }
    
    func nameValidate(text: String, range: NSRange, string: String) {
        let newText = combineText(text: text, range: range, string: string)
        let messageInfo = self.nameValidater.evaluate(with: newText)
        NotificationCenter.default.post(name: Validater.evaluatedNameInformation, object: self, userInfo: messageInfo)
        buttonValidate()
    }
    
    func buttonValidate() {
        var isAllValid : Bool
        if self.idValidater.state() == .valid, self.passwordValidater.state() == .valid,
           self.passwordConfirmValidater.state() == .valid, self.nameValidater.state() == .valid {
            isAllValid = true
        } else {
            isAllValid = false
        }
        NotificationCenter.default.post(name: Validater.isButtonValid, object: self, userInfo: [Validater.TextStateInfo.isAllValid : isAllValid])
    }
}

extension Validater {
    
    enum MessageInfo {
        case text
        case color
    }
    
    enum TextStateInfo {
        case isAllValid
    }
    
    static let evaluatedIdInformation = Notification.Name("valiatedIdInformation")
    static let evaluatedPasswordInformation = Notification.Name("evaluatedPasswordInformation")
    static let evaluatedPasswordConfirmInformation = Notification.Name("evaluatedPasswordConfirmInformation")
    static let evaluatedNameInformation = Notification.Name("evaluatedNameInformation")
    static let isButtonValid = Notification.Name("isButtonValid")


}


