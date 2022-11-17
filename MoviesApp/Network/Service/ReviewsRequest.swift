//
//  ReviewsRequest.swift
//  MoviesApp
//
//  Created by Burak Güzey on 16.11.2022.
//

import Foundation

enum ReviewRequest {
    
    case allReviewRequest(id: Int)
    
}

extension ReviewRequest: Requestable {
    
    var queryItems: [URLQueryItem] {
        switch self {
            
        case .allReviewRequest:
            return  [
                URLQueryItem(name: ServiceConstants.Paths.apiKeyName, value: ServiceConstants.Paths.apiKey),
                URLQueryItem(name: ServiceConstants.Paths.page, value: ServiceConstants.Paths.defaultPage),
                URLQueryItem(name: ServiceConstants.Paths.lang, value: ServiceLanguageManager.currentLanguage())
            ]
        }
    }
    
    var path: String {
        switch self {
        case .allReviewRequest(let id):
            return "/3/movie/\(id)/reviews"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .allReviewRequest:
            return .get
        }
    }
    
    var parameters: Data? {
        switch self {
        case .allReviewRequest:
            return nil
        }
    }
}
