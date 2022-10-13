
  Language .swift
  MoviesApp

  Created by Burak Güzey on 24.09.2022.


import Foundation

struct Language {
    
    var currentLanguage = Locale.current.languageCode
     
    if let currentLanguage
    if currentLanguage == "" {
            languageString = "tr"
        } else {
            languageString = "en-US"
        }
    }
