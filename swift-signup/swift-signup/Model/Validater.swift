
import Foundation
import UIKit

class Validater {
    private var idValidater: IdValidater
    private var passwordValidater: PasswordValidater
    private var passwordConfirmValidater: PasswordConfirmValidater
    private var nameValidater: NameValidater
    
    init() {
        self.idValidater = IdValidater()
        self.passwordValidater = PasswordValidater()
        self.passwordConfirmValidater = PasswordConfirmValidater()
        self.nameValidater = NameValidater()
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


