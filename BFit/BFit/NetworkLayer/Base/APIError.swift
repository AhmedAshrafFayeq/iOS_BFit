//
//  APIError.swift
//  BFit
//
//  Created by Ahmed Fayeq on 13/08/2022.
//

import Foundation

// MARK: - APIError
enum APIError : String, Error {
    case noInternet, notFound
        
    var description : String {
        get {
            switch(self) {
            case .noInternet:
                return "NO_INTERNET_CONNECTION".localized(forLanguageCode: NSLocale.preferredLanguages[0])
            case .notFound:
                return "ERROR_DATA".localized(forLanguageCode: NSLocale.preferredLanguages[0])
            }
        }
    }
}
