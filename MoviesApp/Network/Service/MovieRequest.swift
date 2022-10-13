//
//  MovieRequest.swift
//  MoviesApp
//
//  Created by Burak Güzey on 30.08.2022.
//

import Foundation

enum MovieRequest {
    
    case allMovies(pageString: String)
    case movieDetail(id: Int)
    
}

extension MovieRequest: Requestable {
    
    var queryItems: [URLQueryItem] {
        switch self {
            
        case .allMovies(let pageString):
            return  [
                URLQueryItem(name: ServiceConstants.Paths.apiKeyName, value: ServiceConstants.Paths.apiKey),
                URLQueryItem(name: ServiceConstants.Paths.page, value: pageString),
                URLQueryItem(name: ServiceConstants.Paths.lang, value: ServiceLanguageManager.currentLanguage())
            ]
        case .movieDetail:
            return  [
                URLQueryItem(name: ServiceConstants.Paths.apiKeyName, value: ServiceConstants.Paths.apiKey),
                URLQueryItem(name: ServiceConstants.Paths.page, value: ServiceConstants.Paths.defaultPage),
                URLQueryItem(name: ServiceConstants.Paths.lang, value: ServiceLanguageManager.currentLanguage())
            ]
        }
    }
    
    var path: String {
        switch self {
        case .allMovies:
            return ServiceConstants.Endpoints.allMoviesPath
        case .movieDetail(let id):
            return "/3/movie/\(id)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .allMovies,
                .movieDetail:
            return .get
        }
    }
    
    var parameters: Data? {
        switch self {
        case .allMovies,
                .movieDetail:
            return nil
        }
    }
}
