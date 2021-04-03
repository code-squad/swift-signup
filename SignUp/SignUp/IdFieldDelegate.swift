//
//  SignUpDelegate.swift
//  SignUp
//
//  Created by Ador on 2021/03/29.
//

import UIKit

class IdFieldDelegate: NSObject, UITextFieldDelegate {
    var firstResponserHandler: (() -> Void)?
    private let presenter: IdPresenter
    
    init(presenter: IdPresenter) {
        self.presenter = presenter
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        presenter.activate()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        presenter.unActivate()
        guard let text = textField.text?.replacingOccurrences(of: " ", with: ""), !text.isEmpty else {
            return
        }
        if !validateFormat(for: text) {
            presenter.updateLabel(with: IdCheck.unavailable.rawValue)
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
                self.presenter.updateLabel(with: IdCheck.available.rawValue)
            } else {
                self.presenter.updateLabel(with: IdCheck.alreadyUsing.rawValue)
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
