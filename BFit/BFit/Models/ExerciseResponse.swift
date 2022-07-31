//
//  ExerciseResponse.swift
//  BFit
//
//  Created by Ahmed Fayeq on 26/07/2022.
//

import Foundation

// MARK: - ExcerciseResponse
struct ExerciseResponse: Codable {
    let count: Int
    let next: String
    let results: [Exercise]
}

// MARK: - Exercise
struct Exercise: Codable {
    let id: Int
    let uuid, name: String
    let exerciseBase: Int
    let exerciseDescription, creationDate: String
    let category: Int
    let muscles, musclesSecondary, equipment: [Int]
    let language, license: Int
    let licenseAuthor: String
    let variations: [Int]

    enum CodingKeys: String, CodingKey {
        case id, uuid, name
        case exerciseBase           = "exercise_base"
        case exerciseDescription    = "description"
        case creationDate           = "creation_date"
        case musclesSecondary       = "muscles_secondary"
        case licenseAuthor          = "license_author"
        case category, muscles
        case equipment, language, license
        case variations
    }
}
