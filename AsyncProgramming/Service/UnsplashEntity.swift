//
//  UnsplashEntity.swift
//  AsyncProgramming
//
//  Created by ibrahim oktay on 10.05.2020.
//  Copyright © 2020 io. All rights reserved.
//
import Foundation

// MARK: - UnsplashResponse
struct UnsplashResponse: Codable {
    let total, totalPages: Int?
    let results: [UResult]?
}

// MARK: - Result
struct UResult: Codable {
    let id: String?
    let createdAt, updatedAt: Date?
    let promotedAt: Date?
    let width, height: Int?
    let color: String?
    let resultDescription: String?
    let altDescription: String?
    let urls: Urls?
    let links: ResultLinks?
    let categories: [String]?
    let likes: Int?
    let likedByUser: Bool?
    let currentUserCollections: [String]?
    let sponsorship: String?
    let user: User?
    let tags: [Tag]?
}

// MARK: - ResultLinks
struct ResultLinks: Codable {
    let linksSelf, html, download, downloadLocation: String?
}

// MARK: - Tag
struct Tag: Codable {
    let title: String?
    let source: Source?
}

// MARK: - Source
struct Source: Codable {
    let ancestry: Ancestry?
    let title, subtitle, sourceDescription, metaTitle: String?
    let metaDescription: String?
    let coverPhoto: CoverPhoto?
}

// MARK: - Ancestry
struct Ancestry: Codable {
    let type, category, subcategory: Category?
}

// MARK: - Category
struct Category: Codable {
    let slug, prettySlug: String?
}

// MARK: - CoverPhoto
struct CoverPhoto: Codable {
    let id: String?
    let createdAt, updatedAt: Date?
    let promotedAt: Date?
    let width, height: Int?
    let color: String?
    let coverPhotoDescription, altDescription: String?
    let urls: Urls?
    let links: ResultLinks?
    let categories: [String]?
    let likes: Int?
    let likedByUser: Bool?
    let currentUserCollections: [String]?
    let user: User?
    let sponsorship: String?
}

// MARK: - Urls
struct Urls: Codable {
    let raw, full, regular, small: String?
    let thumb: String?
}

// MARK: - User
struct User: Codable {
    let id: String?
    let updatedAt: Date?
    let username, name, firstName, lastName: String?
    let twitterUsername: String?
    let portfolioURL: String?
    let bio, location: String?
    let links: UserLinks?
    let profileImage: ProfileImage?
    let instagramUsername: String?
    let totalCollections, totalLikes, totalPhotos: Int?
    let acceptedTos: Bool?
}

// MARK: - UserLinks
struct UserLinks: Codable {
    let linksSelf, html, photos, likes: String?
    let portfolio, following, followers: String?
}

// MARK: - ProfileImage
struct ProfileImage: Codable {
    let small, medium, large: String?
}
