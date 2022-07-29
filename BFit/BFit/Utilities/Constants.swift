//
//  Constants.swift
//  BFit
//
//  Created by Ahmed Fayeq on 29/07/2022.
//

import Foundation

struct ServerConstants {
    static let baseServer = "https://wger.de/api/v2/"
    static let language = "/?language="
    static let format = "&format=json"
    
        
    static func getLanguage() -> Int {
        let language = NSLocale.preferredLanguages[0].components(separatedBy: "-").first ?? NSLocale.preferredLanguages[0]
        if language == "de" { return 1 }
        else { return 2 }
    }
}
