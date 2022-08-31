//
//  MovieRequest.swift
//  MoviesApp
//
//  Created by Burak Güzey on 30.08.2022.
//

import Foundation

enum MovieRequest {
    
    case allMovies
    case MovieDetail(id: Int)
    
}

extension MovieRequest: Requestable {
    
    var path: String {
        switch self {
        case .allMovies:
            return "movie/popular"
        case .MovieDetail(let id):
            return "movie/\(id)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .allMovies,
             .MovieDetail:
            return .get
        }
    }
    
    var parameters: Data? {
        switch self {
        case .allMovies,
             .MovieDetail:
            return nil
        }
    }
    
    var queryItems: [String : String]? {
        switch self {
        case .allMovies,
             .MovieDetail:
            return nil 
        }
    }
        
    
}
