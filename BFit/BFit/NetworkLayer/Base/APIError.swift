//
//  APIError.swift
//  BFit
//
//  Created by Ahmed Fayeq on 13/08/2022.
//

import Foundation

// MARK: - APIError
enum APIError : String, Error {
    case noInternet = "Please check internet connection"
    case notFound = "No data found or page removed"
}
