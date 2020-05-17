//
//  ViewModel.swift
//  AsyncProgramming
//
//  Created by ibrahim oktay on 10.05.2020.
//  Copyright © 2020 io. All rights reserved.
//

import Foundation
import UIKit

class ViewModel {
    let services: [ImageService]!
    var imageUrls = [String]()
    
    var workItem: DispatchWorkItem?
    var dispatchGroup: DispatchGroup!
        
    init(services: [ImageService]) {
        self.services = services
        self.dispatchGroup = DispatchGroup()
    }
    
    func search(_ query: String, completion: @escaping ([String]) -> Void) {
        guard query.count > 3 else {
            completion([String]())
            return
        }
        
        workItem?.cancel()
        imageUrls.removeAll()
        workItem = DispatchWorkItem { [weak self] in
            guard let self = self else {
                return
            }
            
            for service in self.services {
                self.dispatchGroup.enter()
                service.search(query) { [weak self] urls in
                    self?.imageUrls.append(contentsOf: urls)
                    self?.dispatchGroup.leave()
                }
            }
            
            self.dispatchGroup.notify(queue: .main) {
                completion(self.imageUrls)
            }
        }
        
        if let workItem = workItem {
            DispatchQueue.global().asyncAfter(deadline: .now() + 1, execute: workItem)
        }
    }
}
