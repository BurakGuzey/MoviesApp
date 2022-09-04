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
    var queryItems: [URLQueryItem] { get }

    
    func toURLRequest() -> URLRequest
    
}

extension Requestable {
    
    var baseURL: URL {
        return URL(string: ServiceConstants.baseURL)!
    }
        
    var queryItems: [URLQueryItem] {
        return  [URLQueryItem(name: "api_key", value: ServiceConstants.apiKey)]
    }
        
    func toURLRequest() -> URLRequest {
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = ServiceConstants.baseURL
        components.queryItems = queryItems
        
        let request = URLRequest(url: URL(string: components.string!)!)
        
        return request
    }
    
}
