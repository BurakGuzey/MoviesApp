//
//  Requestable.swift
//  MoviesApp
//
//  Created by Burak Güzey on 30.08.2022.
//

import Foundation

protocol Requestable {
    
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: Data? { get }
//    var queryItems: [String: String]? { get }
    func toURLRequest() -> URLRequest
    
}

extension Requestable {
    
    var baseURL: URL {
        return URL(string: "https://api.themoviedb.org/3/")!
    }
    
    func toURLRequest() -> URLRequest {

        var request = URLRequest(url: baseURL.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        if let parameters = parameters {
            request.httpBody = parameters
        }
//        if let queryItems = queryItems {
//
//        }
        return request
    }
}
