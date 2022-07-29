//
//  ExerciseInfoResponse.swift
//  BFit
//
//  Created by Ahmed Fayeq on 28/07/2022.
//

import Foundation

// MARK: - ExerciseInfoResponse
struct ExerciseInfoResponse: Codable {
    let count: Int
    let next: String
    let results: [ExerciseInfo]
}

// MARK: - Result
struct ExerciseInfo: Codable {
    let id: Int
    let name, uuid: String
    let exerciseBaseID: Int
    let exerciseDescription, creationDate: String
    let category: Category
    let muscles, musclesSecondary: [Muscle]
    let equipment: [Category]
    let language, license: Language
    let licenseAuthor: String
    let images: [Image]
    let comments: [Comment]
    let variations: [Int]

    enum CodingKeys: String, CodingKey {
        case id, name, uuid
        case exerciseBaseID = "exercise_base_id"
        case exerciseDescription = "description"
        case creationDate = "creation_date"
        case category, muscles
        case musclesSecondary = "muscles_secondary"
        case equipment, language, license
        case licenseAuthor = "license_author"
        case images, comments, variations
    }
}

// MARK: - Category
struct Category: Codable {
    let id: Int
    let name: String
}

// MARK: - Comment
struct Comment: Codable {
    let id, exercise: Int
    let comment: String
}

// MARK: - Language
struct Language: Codable {
    let id: Int
    let shortName, fullName: String
    let url: String?

    enum CodingKeys: String, CodingKey {
        case id
        case shortName = "short_name"
        case fullName = "full_name"
        case url
    }
}

// MARK: - Muscle
struct Muscle: Codable {
    let id: Int
    let name: String
    let isFront: Bool
    let nameEn, imageURLMain, imageURLSecondary: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case isFront = "is_front"
        case nameEn = "name_en"
        case imageURLMain = "image_url_main"
        case imageURLSecondary = "image_url_secondary"
    }
}

