//
//  UsernameTextFieldDelegate.swift
//  SignupApp
//
//  Created by Song on 2021/03/31.
//

import UIKit

enum NotificationName {
    static let DidChangeValidation = Foundation.Notification.Name("DidChangePassword")
    static let DidChangePassword = Foundation.Notification.Name("DidChangePassword")
}

class UsernameTextFieldDelegate: NSObject, UITextFieldDelegate, UsernameListManagerDelegate {
    private var usernameListManager = UsernameListManager(urlString: "https://8r6ruzgzve.execute-api.ap-northeast-2.amazonaws.com/default/SwiftCamp")
    private var usernames: [String] = []
    private let validationManager = ValidationManager()
    private let validUsername: () -> ()
    private let invalidUsername: () -> ()
    private let alreadyExistingUsername: () -> ()
    var validated: Bool = false
    
    init(validUsername: @escaping () -> (), invalidUsername: @escaping () -> (), alreadyExistingUsername: @escaping () -> ()) {
        self.validUsername = validUsername
        self.invalidUsername = invalidUsername
        self.alreadyExistingUsername = alreadyExistingUsername
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        usernameListManager.delegate = self
        usernameListManager.performRequest()
        
        guard let username = textField.text else { return }
        validated = validate(text: username)
        NotificationCenter.default.post(name: NotificationName.DidChangeValidation, object: validated)
    }
    
    func validate(text: String) -> Bool {
        if usernames.contains(text) {
            alreadyExistingUsername()
            return false
        } else {
            if validationManager.isAvailable(username: text) {
                validUsername()
                return true
            } else {
                invalidUsername()
                return false
            }
        }
    }
    
    func didUpdateUsernameList(with usernames: [String]) {
        self.usernames = usernames
    }
    
    func didFailWithError(error: Error) {
        print(error.localizedDescription)
    }
}
