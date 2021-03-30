//
//  request.swift
//  SignUp
//
//  Created by HOONHA CHOI on 2021/03/29.
//

import Foundation

class Service {
    private let url = URL(string: "https://8r6ruzgzve.execute-api.ap-northeast-2.amazonaws.com/default/SwiftCamp")!
    
    func request(completion : @escaping ([String]) -> Void) {
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            guard error == nil else { return }
            guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            let result = self.match(text: String(data: data, encoding: .utf8) ?? "")
            completion(result)
        }).resume()
    }
    
    func match(text : String) -> [String] {
        guard let regex = try? NSRegularExpression(pattern: "[a-zA-Z]+", options: .caseInsensitive) else { return [] }
        let result = regex.matches(in: text, range: _NSRange(location: 0, length: text.count))
        return result.map {
            String(text[Range($0.range, in: text)!])
        }
        
    }
}



