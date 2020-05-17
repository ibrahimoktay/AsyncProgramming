//
//  Unsplash.swift
//  AsyncProgramming
//
//  Created by ibrahim oktay on 10.05.2020.
//  Copyright © 2020 io. All rights reserved.
//

import Foundation

class UnsplashAPI: ImageService {
    var baseURL = "https://api.unsplash.com"
    
    func search(_ query: String, _ completion: @escaping ([String]) -> Void) {
        getImages(query) { response in
            switch response {
            case .success(let data):
                let urls = data.results?.compactMap{ $0.urls?.small }
                completion(urls!)
            case .failure:
                completion([String]())
            }
        }
    }
    
    func getImages(_ query: String, _ completion: @escaping (Result<UnsplashResponse, APIError>) -> Void) {
        let url = "\(baseURL)/search/photos?query=\(query)&page=1&per_page=10"
        var request = URLRequest(url: URL(string: url)!)
        request.addValue(Authorization.UNSPLASH_CLIENT_ID, forHTTPHeaderField: "Authorization")
        
        call(request, completion)
    }
}
