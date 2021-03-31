//
//  JSONResponseDecoder.swift
//  SignupApp
//
//  Created by Issac on 2021/04/01.
//

import Foundation

class JSONResponseDecoder {
    func decode<T: Decodable>(_ data: Data) throws -> T {
        let jsonDeocoder = JSONDecoder()
        return try jsonDeocoder.decode(T.self, from: data)
    }
}
