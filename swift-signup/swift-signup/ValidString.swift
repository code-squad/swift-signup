//
//  validString.swift
//  swift-signup
//
//  Created by 박정하 on 2021/03/31.
//

import Foundation

extension String{
    
    func isValidString(regex: String) -> Bool {
        do{
            let regex = try NSRegularExpression(pattern: regex, options: [])
            return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.count)) != nil
        }
        catch{
            print(error.localizedDescription)
            return false
        }
    }
    
    func getArrayAfterRegex(regex: String) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let results = regex.matches(in: self,
                                        range: NSRange(self.startIndex..., in: self))
            return results.map {
                String(self[Range($0.range, in: self)!])
            }
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
}
