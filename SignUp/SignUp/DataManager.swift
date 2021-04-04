//
//  DataManager.swift
//  SignUp
//
//  Created by Ador on 2021/04/04.
//

import Foundation

class DataManager {
    static func encode(json: [String: String]) -> Data? {
        return try? JSONSerialization.data(withJSONObject: json, options: [])
    }
    
    static func decode(data: Data) -> [String: Any]? {
        return try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
    }
}
