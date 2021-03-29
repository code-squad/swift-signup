//
//  String.swift
//  SignupApp
//
//  Created by Issac on 2021/03/29.
//

import Foundation

extension String {
    func match(for regex: String) -> Bool {
        guard let regex = try? NSRegularExpression(pattern: regex) else {
            return false
        }

        return regex.matches(in: self, range: NSRange(self.startIndex..., in: self)).count > 0
    }
}
