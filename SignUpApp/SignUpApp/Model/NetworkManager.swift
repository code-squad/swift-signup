//
//  NetworkManager.swift
//  SignUpApp
//
//  Created by sonjuhyeong on 2021/03/31.
//

import Foundation


class NetworkManager {
    static func getData(completionHandler: @escaping ([String]) -> ())  {
        let urlString: String = "https://8r6ruzgzve.execute-api.ap-northeast-2.amazonaws.com/default/SwiftCamp"
        guard let url = URL(string: urlString) else {
            print("URL is nil")
            return
        }
        let session = URLSession(configuration: .default)
        
        let dataTask = session.dataTask(with: url) {(data, response, error) in
            guard error == nil else { return }
            guard let resultData = data else { return }
            
            do{
                let decoder = JSONDecoder()
                let result = try decoder.decode([String].self, from: resultData)
                completionHandler(result)
            }catch let error {
                print("error: \(error.localizedDescription)")
            }
            
        }
        dataTask.resume()
    }
}
