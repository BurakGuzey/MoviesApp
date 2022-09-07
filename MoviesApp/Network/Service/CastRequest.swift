//
//  CastRequest.swift
//  MoviesApp
//
//  Created by Burak Güzey on 7.09.2022.
//

import Foundation

enum CastRequest {
    
    case allCast(id: Int)
    case castDetail(id: Int)
    
}

extension CastRequest: Requestable {
    
    var path: String {
        switch self {
        case .allCast(id: let id):
            return "/3/movie/\(id)/credits"
        case .castDetail(id: let id):
            return "/3/person/\(id)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .allCast,
             .castDetail:
            return .get
        }
    }
    
    var parameters: Data? {
        switch self {
        case .allCast,
             .castDetail:
            return nil
        }
    }
}
