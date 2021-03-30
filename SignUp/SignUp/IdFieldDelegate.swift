//
//  SignUpDelegate.swift
//  SignUp
//
//  Created by Ador on 2021/03/29.
//

import UIKit

class IdFieldDelegate: NSObject, UITextFieldDelegate {
    
    var handler: (((IdCheck, UIColor)) -> Void)?
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        guard let text = textField.text?.replacingOccurrences(of: " ", with: ""), !text.isEmpty else {
            return false
        }
        if !check(for: text) {
            handler?((.unavailable, .systemRed ))
        } else {
            checkAvailable(for: text)
        }
        return true
    }
    
    func check(for id: String) -> Bool {
        let reg = "[a-z0-9_-]{5,20}"
        let predicate = NSPredicate(format:"SELF MATCHES %@", reg)
        return predicate.evaluate(with: id)
    }
    
    func checkAvailable(for id: String) {
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
                self.handler?((.available, .systemGreen))
            } else {
                self.handler?((.alreadyUsing, .systemRed))
            }
        }).resume()
    }
}

enum IdCheck: String {
    case available = "사용 가능한 아이디입니다."
    case alreadyUsing = "이미 사용 중인 아이디입니다."
    case unavailable = "5~20자의 영문 소문자, 숫자와 특수기호(_)(-)만 사용 가능합니다."
}
