//
//  NetworkCenter.swift
//  SignupApp
//
//  Created by Issac on 2021/03/30.
//

import Foundation

class NetworkCenter {
    static let shared: NetworkCenter = NetworkCenter()
    
    public func receiveIDData(url: URL, callback: @escaping (Data) -> ()) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard error == nil else { print(error!.localizedDescription); return }
            guard let data = data else { return }
            
            DispatchQueue.main.async {
                callback(data)
            }
        }
        
        task.resume()
    }
}
