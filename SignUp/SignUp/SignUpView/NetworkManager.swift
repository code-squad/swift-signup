//
//  NetworkManager.swift
//  SignUp
//
//  Created by 이다훈 on 2021/03/30.
//

import Foundation
class NetworkManager {
    static var shared = NetworkManager()
    
    private let url = URL.init(string: "https://8r6ruzgzve.execute-api.ap-northeast-2.amazonaws.com/default/SwiftCamp")
    
    func getUserList(closure : @escaping ([String]?) -> Void) {
        guard let url = self.url else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request, completionHandler: {(data,response,error) in
            
            let userList = self.serialize(data: data)
            
            closure(userList)
        }).resume()
    }
    
    func serialize(data : Data?) -> Array<String> {
        guard let data = data else {
            return [String]()
        }
        let decoder = try? JSONSerialization.jsonObject(with: data, options: []) as? Array<String>
        guard let userList = decoder?.compactMap({$0}) else {
            return [String]()
            
        }
        return userList
    }
    
    func postUser(userInfo : UserInformation) {
        guard let url = self.url else {
            return
        }
        let sendData = try? JSONEncoder().encode(userInfo)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = sendData
        
        URLSession.shared.dataTask(with: request, completionHandler: {(data,response,error) in
            guard let data = data else {
                return
            }
            let decoder = try? JSONDecoder().decode(NetworkResponse.self, from: data)
            guard let returnData = decoder else {
                return
            }
            // 필요한 내용 하단에 구현
        }).resume()
    }
}

struct NetworkResponse : Codable {
    var result : String
    var status : String
}
