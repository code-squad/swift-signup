//
//  String+Validation.swift
//  SignupApp
//
//  Created by Song on 2021/03/30.
//

import Foundation

extension String {
    public func validate(with regex: String) -> Bool {
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: self)
    }
}
