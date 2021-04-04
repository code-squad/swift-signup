//
//  ValidateManager.swift
//  SignUp
//
//  Created by Ador on 2021/04/03.
//

import Foundation

class ValidateManager {
    enum ValidateError: Error {
        case alreadyUsing
    }
    
    static var url = URL(string: "https://8r6ruzgzve.execute-api.ap-northeast-2.amazonaws.com/default/SwiftCamp")!
    
    static func validate(for id: String, completion: @escaping (Result<String, Error>) -> Void) {
        var req = URLRequest(url: url)
        let bodyData = encode(json: ["id": id, "password": ""])
        req.httpMethod = "POST"
        req.httpBody = bodyData
        request(for: req, completion: { result in
            switch result {
            case .success(let data):
                guard let json = decode(data: data),
                      let status = json["status"] as? String else {
                    return
                }
                if status == "200" {
                    completion(.success("success"))
                } else {
                    completion(.failure(ValidateError.alreadyUsing))
                }
            case .failure(_):
                completion(.failure(ValidateError.alreadyUsing))
            }
        })
    }
    
    static func request(for request: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) {
        URLSession.shared.dataTask(with: request, completionHandler: { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            completion(.success(data))
        }).resume()
    }
    
    private static func encode(json: [String: String]) -> Data? {
        return try? JSONSerialization.data(withJSONObject: json, options: [])
    }
    
    private static func decode(data: Data) -> [String: Any]? {
        return try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
    }
}
