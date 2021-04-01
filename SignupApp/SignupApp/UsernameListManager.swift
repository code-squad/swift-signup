//
//  UsernameListManager.swift
//  SignupApp
//
//  Created by Song on 2021/03/31.
//

import Foundation

protocol UsernameListManagerDelegate {
    func didUpdateUsernameList(with usernames: [String])
    func didFailWithError(error: Error)
}

struct UsernameListManager {
    let urlString: String
    var delegate: UsernameListManagerDelegate?
    
    func performRequest() {
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                self.delegate?.didFailWithError(error: error!)
                return
            }
            guard let data = data else { return }
            guard let response = response as? HTTPURLResponse, (200..<299) ~= response.statusCode else { return }
            guard let usernames = self.parseJSON(data) else { return }
            self.delegate?.didUpdateUsernameList(with: usernames)
        }
        task.resume()
    }
    
    func parseJSON(_ userData: Data) -> [String]? {
        do {
            guard let jsonObject = try JSONSerialization.jsonObject(with: userData) as? [String] else {
                return nil
            }
            return jsonObject
        } catch {
            self.delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
