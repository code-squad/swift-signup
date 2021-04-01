//
//  IDChecker.swift
//  swift-signup
//
//  Created by 박정하 on 2021/04/01.
//

import Foundation

class IDChecker {
    func CheckServerID(text: String, completionHandler: @escaping (String) -> Void){
        let body = ["id": "\(text)", "password":""]
        let bodyJSON = try! JSONSerialization.data(withJSONObject: body, options: [])
        guard let url = URL(string: "https://8r6ruzgzve.execute-api.ap-northeast-2.amazonaws.com/default/SwiftCamp") else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = bodyJSON
        let _ = URLSession.shared.dataTask(with: request) {(data, response, error) in
            guard let data = data,
                  let dataJSON = try? JSONSerialization.jsonObject(with: data, options: []) as? [String:Any],
                  let statusCode = dataJSON["status"] as? String else {
                return
            }
            completionHandler(statusCode)
        }.resume()
    }
}
