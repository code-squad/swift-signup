//
//  ViewController.swift
//  signup
//
//  Created by Song on 2021/03/29.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet var signUptextFieldCollection: [SignUpTextField]!
    @IBOutlet var infoLabelCollection: [InfoLabel]!

    private var validateManagers = [ValidateManager]()
    private var textFieldDelegates = [SignUpTextFieldDelegate]()
    
    @IBOutlet weak var nextButton: SignUpButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureDelegates()
        
        nextButton.configureColors()
        nextButton.disable()
        
        addObservers()
    }
    
    private func configureDelegates() {
        validateManagers = [IDValidateManager(),
                            PasswordValidateManager(),
                            PasswordConfirmManager(),
                            UserNameValidateManager()]
        
        validateManagers.forEach { (manager) in
            textFieldDelegates.append(SignUpTextFieldDelegate(validateManager: manager))
        }
        
        for i in 0..<signUptextFieldCollection.count {
            signUptextFieldCollection[i].delegate = textFieldDelegates[i]
        }
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        //다음으로!
    }
    
    
    //MARK: - Notification Methods
    private func addObservers() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didStateUpdate(_:)),
                                               name: SignUpTextFieldDelegate.NotiKeys.stateChanged,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didValidateTextField(_:)),
                                               name: SignUpTextFieldDelegate.NotiKeys.validateDone,
                                               object: nil)
    }
    
    @objc func didStateUpdate(_ notification: Notification) {
        guard let sender = notification.object as? ValidateManager else { return }
        
        let senderID = ObjectIdentifier(type(of: sender))
        
        guard let targetIdx = findTargetIndex(for: senderID) else { return }
        
        let targetLabel = infoLabelCollection[targetIdx]
        
        guard let info = notification.userInfo as? [String: Any],
              let status = info["status"] as? Status else { return }
        
        let isValidated = status.isValidated
        let message = status.message
        let value = info["input"] as? String
        
        DispatchQueue.main.async {
            targetLabel.update(isValidated: isValidated, text: message)
            self.updateSignUpInfoList(value: value, key: senderID)
            self.updateButtonState()
        }
    }
    
    private func findTargetIndex(for senderID: ObjectIdentifier) -> Int? {
        var targetIdx: Int?
        
        for (idx, manager) in validateManagers.enumerated() {
            let managerID = ObjectIdentifier(type(of: manager))
            if senderID == managerID {
                targetIdx = idx
                return targetIdx
            }
        }
        return targetIdx
    }
    
    private func updateSignUpInfoList(value: String?, key: ObjectIdentifier) {
        SignUpInfo.list[key] = value
    }
    
    private func updateButtonState() {
        let validCount = validateManagers.map{ ObjectIdentifier(type(of: $0)) }.compactMap{ SignUpInfo.list[$0] }.count
        validCount == 4 ? nextButton.enable() : nextButton.disable()
    }
    
    @objc func didValidateTextField(_ notification: Notification) {
        guard let sender = notification.object as? ValidateManager else { return }
        
        let senderID = ObjectIdentifier(type(of: sender))
        
        guard let currentIdx = findTargetIndex(for: senderID) else { return }
        
        let nextIdx = currentIdx + 1
        guard nextIdx < signUptextFieldCollection.count else { return }
        
        DispatchQueue.main.async {
            self.signUptextFieldCollection[nextIdx].becomeFirstResponder()
        }
    }
}
