//
//  JSONResponseDecoder.swift
//  SignupApp
//
//  Created by Issac on 2021/04/01.
//

import Foundation

class JSONResponseDecoder {
    func decode<T: Decodable>(data: Data, Object:T.Type, completion: @escaping (_ data: T?, _ error: Error?) -> Void) {
        do {
            let jsonDecoder = JSONDecoder()
            let result = try jsonDecoder.decode(T.self, from: data)
            return completion(result, nil)
        } catch let error {
            return completion(nil, error)
        }
    }
}
