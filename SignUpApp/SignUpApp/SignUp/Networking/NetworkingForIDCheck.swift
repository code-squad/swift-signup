//
//  NetworkingForIDCheck.swift
//  SignUpApp
//
//  Created by Jun Ho JANG on 2021/04/05.
//

import Foundation

class NetworkingForIDCheck {
    
    static var idData = [String]()
    
    static func getData(completion: @escaping ([String]) -> ()) {
        let URLString = "https://8r6ruzgzve.execute-api.ap-northeast-2.amazonaws.com/default/SwiftCamp"
        if let url = URL(string: URLString) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data {
                    do {
                        let res = try JSONDecoder().decode([String].self, from: data)
                        idData = res
                        completion(res)
                    } catch let error {
                        print(error)
                    }
                }
            }.resume()
        }
    }
    
}
