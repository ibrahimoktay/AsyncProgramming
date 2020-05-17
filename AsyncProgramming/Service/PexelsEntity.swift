//
//  PexelsEntity.swift
//  AsyncProgramming
//
//  Created by ibrahim oktay on 10.05.2020.
//  Copyright © 2020 io. All rights reserved.
//
import Foundation

// MARK: - PexelsResponse
struct PexelsResponse: Codable {
    let totalResults, page, perPage: Int?
    let photos: [Photo]?
    let nextPage: String?
}

// MARK: - Photo
struct Photo: Codable {
    let id, width, height: Int?
    let url: String?
    let photographer: String?
    let photographerURL: String?
    let photographerID: Int?
    let src: Src?
    let liked: Bool?
}

// MARK: - Src
struct Src: Codable {
    let original, large2X, large, medium: String?
    let small, portrait, landscape, tiny: String?
}
