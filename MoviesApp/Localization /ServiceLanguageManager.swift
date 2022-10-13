//
//  LanguageDecision.swift
//  MoviesApp
//
//  Created by Burak Güzey on 26.09.2022.
//

import Foundation

struct ServiceLanguageManager {
    
    static func currentLanguage() -> String {
        
        let currentLang = Locale.current.languageCode
        var currentLanguage = String()
        
        if currentLang! == "tr" {
            currentLanguage = ServiceConstants.Paths.trLangString
        } else {
            currentLanguage = ServiceConstants.Paths.defaultLangString
        }
        return currentLanguage
    }
    
}
