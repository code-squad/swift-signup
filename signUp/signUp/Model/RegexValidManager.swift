import Foundation

class RegexValidManager {
    private var idList = [String]()
    
    init() {
        NetworkHandler.getData { serverIdList in
            self.idList = serverIdList
        }
    }
    
    func isEmptyTextField(text: String?) -> Bool {
        let textCount = text?.count ?? 0
        return textCount == 0
    }
    
    func isOverlappedID(id: String?) -> Bool {
        guard let userId = id else { return false }
        if !idList.contains(userId) { return true }
        return false
    }
    
    func isValidElementForID(_ id: String?) -> Bool {
        let idElement = id?.getArrayAfterRegex(regex: "[A-Z!@#$%]").count ?? 0
        return idElement == 0
    }
    
    func isValidCountForID(_ id: String?) -> Bool {
        let idCount = id?.getArrayAfterRegex(regex: "[a-z0-9_-]").count ?? 0
        return idCount>=5 && idCount<=20
    }
    
    func isValidPasswordElement(_ password: String?) -> Bool {
        let element = password?.getArrayAfterRegex(regex: "[!@#$%]").count ?? 0
        return element >= 1
    }
    
    func isValidCountForPassWord(_ password: String?) -> Bool {
        let passCount = password?.getArrayAfterRegex(regex: "[a-zA-Z0-9!@#$%]").count ?? 0
        return passCount >= 8 && passCount <= 16
    }
    
    func isEqualForPassword(_ firstPassword: String?, _ secondPassword: String?) -> Bool {
        if let password1 = firstPassword, let password2 = secondPassword {
            return password1 == password2
        }
        return false
    }
    
    func checkValidNameCount(_ name: String?) -> Bool {
        let nameTest = name?.getArrayAfterRegex(regex: "[가-힣]").count ?? 0
        return nameTest >= 2
    }
}
