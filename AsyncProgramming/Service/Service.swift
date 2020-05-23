//
//  Service.swift
//  AsyncProgramming
//
//  Created by ibrahim oktay on 10.05.2020.
//  Copyright © 2020 io. All rights reserved.
//

import Foundation
import Combine

protocol ImageService {
    
    func search(_ query: String, _ completion: @escaping ([String]) -> Void)
    
    func search(_ query: String) -> AnyPublisher<[String], Never>
}

enum APIError: Error {
    case noData
    case parsing
}

func call<T: Decodable>(_ request: URLRequest, _ completion: @escaping (Result<T, APIError>) -> Void) {
    let urlSession = URLSession.shared.dataTask(with: request) { (data, response, error) in
        if let data = data {
            if let object = try? JSONDecoder().decode(T.self, from: data) {
                DispatchQueue.main.async {
                    // update our UI
                    completion(.success(object))
                }
                
            } else {
                completion(.failure(.parsing))
            }
        } else {
            completion(.failure(.noData))
        }
    }
    
    urlSession.resume()
}


func call<T: Decodable>(_ request: URLRequest) -> AnyPublisher<T, Error> {
    let publisher = URLSession.shared.dataTaskPublisher(for: request)
        .map{ $0.data }
        .decode(type: T.self, decoder: JSONDecoder())
        .eraseToAnyPublisher()
    
    return publisher
}
