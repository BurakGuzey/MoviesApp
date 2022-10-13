//
//  SearchRequest.swift
//  MoviesApp
//
//  Created by Burak Güzey on 15.09.2022.
//

import Foundation

enum SearchRequest {
    
    case searchMovie(text: String)
    
}

extension SearchRequest: Requestable {
    
    
    var path: String {
        switch self {
        case .searchMovie:
            return ServiceConstants.Endpoints.searchPath
        }
        
    }
    
    var method: HTTPMethod {
        switch self {
        case .searchMovie:
            return .get
        }
    }
    
    var parameters: Data? {
        switch self {
        case .searchMovie:
            return nil
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .searchMovie(let text):
            return [URLQueryItem(name: ServiceConstants.Paths.apiKeyName, value: ServiceConstants.Paths.apiKey),
                    URLQueryItem(name: ServiceConstants.Paths.page, value: ServiceConstants.Paths.defaultPage),
                    URLQueryItem(name: ServiceConstants.Paths.lang, value: ServiceLanguageManager.currentLanguage()),
                    URLQueryItem(name: ServiceConstants.Paths.query, value: text)]
        }
    }
}
