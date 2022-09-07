//
//  MovieRequest.swift
//  MoviesApp
//
//  Created by Burak Güzey on 30.08.2022.
//

import Foundation

enum MovieRequest {
    
    case allMovies
    case movieDetail(id: Int)
    
}

extension MovieRequest: Requestable {
    
    var path: String {
        switch self {
        case .allMovies:
            return ServiceConstants.allMoviesPath
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
