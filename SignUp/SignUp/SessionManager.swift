//
//  SessionManager.swift
//  SignUp
//
//  Created by Ador on 2021/04/04.
//

import Foundation

class SessionManager {
    static func request(for request: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) {
        URLSession.shared.dataTask(with: request, completionHandler: { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            completion(.success(data))
        }).resume()
    }
}
