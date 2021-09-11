//
//  SignUpInfo.swift
//  SignUpApp
//
//  Created by Jun Ho JANG on 2021/03/30.
//

import Foundation

struct SignUpInfo {
    
    let title: String
    let placeholder: String
    let warning: String
    
    init(title: String, placeholder: String, warning: String) {
        self.title = title
        self.placeholder = placeholder
        self.warning = warning
    }
    
}
