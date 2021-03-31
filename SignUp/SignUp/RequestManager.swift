//
//  SignUpManager.swift
//  SignUp
//
//  Created by 양준혁 on 2021/03/31.
//

import Foundation

class RequestManager {
    
    static func requestGet(id: String, completion: @escaping (RequestReturnType) -> Void) {
        
        guard let url = URL(string: "https://8r6ruzgzve.execute-api.ap-northeast-2.amazonaws.com/default/SwiftCamp") else { return }
        
        var request = URLRequest(url: url)
        guard let encodedData = try? JSONEncoder().encode(IdentifierData(id: id, password: "")) else { return }
        request.httpMethod = "POST"
        request.httpBody = encodedData
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                return
            }
            guard let data = data else { return }
            guard let decodedData = try? JSONDecoder().decode(URLResponse.self, from: data) else { return }
            
            completion(changeType(result: decodedData.result)!)
        }.resume()
    }
    
    static func changeType(result: String) -> RequestReturnType? {
        if result == "OK" {
            return RequestReturnType.ok
        }
        if result == "parameter error" {
            return RequestReturnType.parameterError
        }
        if result == "id aready exist" {
            return RequestReturnType.exist
        }
        return nil
    }
    
    
}

enum RequestReturnType {
    case ok, parameterError, exist
}


struct URLResponse: Codable {
    var result: String
    var status: String
}
