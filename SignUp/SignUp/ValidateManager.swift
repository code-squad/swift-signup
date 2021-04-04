//
//  ValidateManager.swift
//  SignUp
//
//  Created by Ador on 2021/04/03.
//

import Foundation

class ValidateManager {
    enum ValidateError: Error {
        case alreadyUsingId
    }
    
    static var url = URL(string: "https://8r6ruzgzve.execute-api.ap-northeast-2.amazonaws.com/default/SwiftCamp")!
    
    static func validate(for id: String, completion: @escaping (Result<String, Error>) -> Void) {
        var req = URLRequest(url: url)
        let bodyData = DataManager.encode(json: ["id": id, "password": ""])
        req.httpMethod = "POST"
        req.httpBody = bodyData
        SessionManager.request(for: req, completion: { result in
            switch result {
            case .success(let data):
                guard let json = DataManager.decode(data: data),
                      let status = json["status"] as? String else {
                    return
                }
                if status == "200" {
                    completion(.success("success"))
                } else {
                    completion(.failure(ValidateError.alreadyUsingId))
                }
            case .failure(_):
                completion(.failure(ValidateError.alreadyUsingId))
            }
        })
    }
    
    
}
