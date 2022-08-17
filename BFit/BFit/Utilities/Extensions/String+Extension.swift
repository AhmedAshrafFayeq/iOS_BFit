//
//  String+Extensions.swift
//  BFit
//
//  Created by Ahmed Fayeq on 29/07/2022.
//

import Foundation

// String extension for Localization
extension String {
    func localized(forLanguageCode lanCode: String) -> String {
        guard
            let bundlePath = Bundle.main.path(forResource: lanCode, ofType: "lproj"),
            let bundle = Bundle(path: bundlePath)
        else { return "" }
        
        return NSLocalizedString(
            self,
            bundle: bundle,
            value: "",
            comment: ""
        )
    }
}
