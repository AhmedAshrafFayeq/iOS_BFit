//
//  ExcerciseImagesResponse.swift
//  BFit
//
//  Created by Ahmed Fayeq on 26/07/2022.
//

import Foundation

// MARK: - ExcerciseImagesResponse
struct ExcerciseImagesResponse: Codable {
    let count: Int
    let next: String
    let results: [Image]
}

// MARK: - Result
struct Image: Codable {
    let id: Int
    let uuid: String
    let exerciseBase: Int
    let image: String
    let isMain: Bool
    let status, style: String

    enum CodingKeys: String, CodingKey {
        case id, uuid
        case exerciseBase = "exercise_base"
        case isMain       = "is_main"
        case image
        case status, style
    }
}
