//
//  ViewModel.swift
//  AsyncProgramming
//
//  Created by ibrahim oktay on 10.05.2020.
//  Copyright © 2020 io. All rights reserved.
//

import Foundation
import UIKit
import Combine

class ViewModel {
    var cancellables = Set<AnyCancellable>()
    let services: [ImageService]!
    
    @Published var imageUrls = [String]()
    @Published var query: String = ""
    
    var queryPublisher: AnyPublisher<String, Never> {
        return $query
            .filter{ $0.count > 3 }
            .debounce(for: .seconds(1), scheduler: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    init(services: [ImageService]) {
        self.services = services
        queryPublisher
            .flatMap { queryString -> AnyPublisher<[[String]], Never> in
                return Publishers.MergeMany(services.map{ $0.search(queryString) })
                    .collect()
                    .eraseToAnyPublisher()
            }
            .receive(on: RunLoop.main)
            .sink { urls in
                self.imageUrls = urls.flatMap{ $0 }
//                print(urls)
            }
        .store(in: &cancellables)
    }
}
