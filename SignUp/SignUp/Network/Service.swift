//
//  request.swift
//  SignUp
//
//  Created by HOONHA CHOI on 2021/03/29.
//

import Foundation

enum ServiceError : Error {
    case dataEmpty
}

class Service {

    func request(completion : @escaping (Result<responseModel ,ServiceError>) -> Void) {
//        let url = URL(string: "https://8r6ruzgzve.execute-api.ap-northeast-2.amazonaws.com/default/SwiftCamp")!
//
//        URLSession.shared.dataTask(with: url) { (data, response, error) in
//            guard error != nil else {
//                completion(.failure(<#T##Error#>)
//            }
//            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
//                completion(.failure())
//            }
//
//            guard let data = data else {
//                completion(.failure(<#T##Error#>))
//            }
//
//            let result = try? JSONDecoder().decode(responseModel.self, from: data)
//            completion(.success(result))
//        }
    }
}
