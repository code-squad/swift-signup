//
//  SignUpDelegate.swift
//  SignUp
//
//  Created by Ador on 2021/03/29.
//

import UIKit

class IdFieldDelegate: NSObject, UITextFieldDelegate {
    
    var updateLabelHandler: (((IdCheck, UIColor)) -> Void)?
    var firstResponserHandler: (() -> Void)?
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.systemBlue.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 0
        guard let text = textField.text?.replacingOccurrences(of: " ", with: ""), !text.isEmpty else {
            return
        }
        if !validateFormat(for: text) {
            updateLabelHandler?((.unavailable, .systemRed ))
        } else {
            validateAvailable(for: text)
        }
        return
    }
    
    func validateFormat(for id: String) -> Bool {
        let reg = "[a-z0-9_-]{5,20}"
        let predicate = NSPredicate(format:"SELF MATCHES %@", reg)
        return predicate.evaluate(with: id)
    }
    
    func validateAvailable(for id: String) {
        var request = URLRequest(url: URL(string: "https://8r6ruzgzve.execute-api.ap-northeast-2.amazonaws.com/default/SwiftCamp")!)
        let body = ["id": id, "password": ""]
        let bodyData = try? JSONSerialization.data(
            withJSONObject: body,
            options: []
        )
        request.httpMethod = "POST"
        request.httpBody = bodyData
        
        let session = URLSession.shared
        session.dataTask(with: request, completionHandler: { data, response, error in
            guard error == nil else {
                return
            }
            
            guard let result = data,
                  let json = try? JSONSerialization.jsonObject(with: result, options: []) as? [String: Any],
                  let status = json["status"] as? String else {
                return
            }
            
            if status == "200" {
                self.updateLabelHandler?((.available, .systemGreen))
            } else {
                self.updateLabelHandler?((.alreadyUsing, .systemRed))
            }
        }).resume()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        firstResponserHandler?()
        return true
    }
}

enum IdCheck: String {
    case available = "사용 가능한 아이디입니다."
    case alreadyUsing = "이미 사용 중인 아이디입니다."
    case unavailable = "5~20자의 영문 소문자, 숫자와 특수기호(_)(-)만 사용 가능합니다."
}
