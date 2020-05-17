//
//  Pexels.swift
//  AsyncProgramming
//
//  Created by ibrahim oktay on 10.05.2020.
//  Copyright © 2020 io. All rights reserved.
//

import Foundation

class PexelsAPI: ImageService {
    var baseURL = "https://api.pexels.com"
    
    func search(_ query: String, _ completion: @escaping ([String]) -> Void) {
        getImages(query) { response in
            switch response {
            case .success(let data):
                let urls = data.photos?.compactMap{ $0.src?.small }
                completion(urls!)
            case .failure:
                completion([String]())
            }
        }
    }
    
    func getImages(_ query: String, _ completion: @escaping (Result<PexelsResponse, APIError>) -> Void) {
        let url = "\(baseURL)/v1/search?query=\(query)&page=1&per_page=10"
        var request = URLRequest(url: URL(string: url)!)
        request.addValue(Authorization.PEXELS_CLIENT_ID, forHTTPHeaderField: "Authorization")
        
        call(request, completion)
    }
}
