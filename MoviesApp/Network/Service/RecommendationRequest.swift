//
//  RecommendationRequest.swift
//  MoviesApp
//
//  Created by Burak Güzey on 27.09.2022.
//

import Foundation

enum RecommendationRequest {
    
    case allrecommendations(id: Int, pageString: String)
    
}

extension RecommendationRequest: Requestable {
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .allrecommendations(_, let pageString):
            return  [
                URLQueryItem(name: ServiceConstants.Paths.apiKeyName, value: ServiceConstants.Paths.apiKey),
                URLQueryItem(name: ServiceConstants.Paths.page, value: pageString),
                URLQueryItem(name: ServiceConstants.Paths.lang, value: ServiceLanguageManager.currentLanguage())
            ]
        }
    }
    
    var path: String {
        switch self {
        case .allrecommendations(let id, _):
            return "/3/movie/\(id)/recommendations"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .allrecommendations:
            return .get
        }
    }
    
    var parameters: Data? {
        switch self {
        case .allrecommendations:
            return nil
        }
    }
}
