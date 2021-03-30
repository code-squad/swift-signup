//
//  NetworkCenter.swift
//  SignupApp
//
//  Created by Issac on 2021/03/30.
//

import Foundation

class NetworkCenter {
    public func receiveIDList(url: URL, callback: @escaping ([String]) -> ()) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        var IDList = Array<String>()
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else { print(error!.localizedDescription); return }
            guard let data = data else { return }
            do {
                IDList = try JSONDecoder().decode([String].self, from: data)
            } catch {
                print(error.localizedDescription)
                return
            }
            
            DispatchQueue.main.async {
                callback(IDList)
            }
        }
        task.resume()
    }
}
