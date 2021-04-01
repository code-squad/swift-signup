//
//  request.swift
//  SignUp
//
//  Created by HOONHA CHOI on 2021/03/29.
//

import Foundation
import Combine

class Service {
    
  
//        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
//            guard error == nil else { return }
//            guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
//            let result = String(data: data, encoding: .utf8)
//            completion(result ?? "")
//        }).resume()
    
    
    func request(onComplete: @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: "https://8r6ruzgzve.execute-api.ap-northeast-2.amazonaws.com/default/SwiftCamp") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, res, err in
                if let err = err {
                    //onComplete(.failure(err))
                    onComplete(.failure(err))
                    return
                }
                guard let data = data else {
                    let httpResponse = res as! HTTPURLResponse
                    onComplete(.failure(NSError(domain: "no data",
                                                code: httpResponse.statusCode,
                                                userInfo: nil)))
                    
                    return
                }
            
            onComplete(.success(String(data: data, encoding: .utf8) ?? ""))
            }.resume()
        
        
        }
}



