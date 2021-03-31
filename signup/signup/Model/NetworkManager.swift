//
//  NetworkManager.swift
//  signup
//
//  Created by Song on 2021/03/30.
//

import Foundation

class NetworkManager {
    
    private let url: URL?
    
    init(baseAddress: String) {
        self.url = URL(string: baseAddress)
    }
    
    func isExisting(id: String, password: String,
                    completionHandler: @escaping (Bool) -> Void) {
        guard let url = url else { return }
        
        let body = ["id": id, "password": password]
        guard let bodyJSON = JSON(with: body) else { return }
        
        let request = httpRequest(url: url, body: bodyJSON, method: "POST")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else { return }
            
            if let dataList = self.dataList(from: data) {
                let statusCode = dataList["status"] as? String
                statusCode == "200" ? completionHandler(false) : completionHandler(true)
            }
        }
        task.resume()
    }
    
    private func JSON(with infoList: [String: Any]) -> Data? {
        let json = try? JSONSerialization.data(withJSONObject: infoList, options: [])
        return json
    }
    
    private func httpRequest(url: URL, body: Data, method: String) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.httpBody = body
        return request
    }
    
    private func dataList(from data: Data) -> [String: Any]? {
        let dataList = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        return dataList
    }
}

