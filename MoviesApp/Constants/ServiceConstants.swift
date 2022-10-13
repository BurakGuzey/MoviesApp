//
//  File.swift
//  MoviesApp
//
//  Created by Burak Güzey on 1.09.2022.
//

import Foundation

struct ServiceConstants {
    
    struct Paths {
        
        static let page = "page"
        static let lang = "language"
        static let query = "query"
        static let defaultLangString = "en"
        static let trLangString = "tr"
        static let defaultPage = "1"
        static let apiKeyName = "api_key"
        static let apiKey = "16e807f61c3e7c6382feff585c3859ad"
        
    }

    
    struct Endpoints {
        
        static let allMoviesPath = "/3/movie/popular"
        static let searchPath = "/3/search/movie"
        
    }
    
    struct BaseURLs {
        
        static let baseScheme = "https"
        static let baseServiceURL = "api.themoviedb.org"
        static let baseImageURL = "https://image.tmdb.org/t/p/w500"
        
    }
    
}
