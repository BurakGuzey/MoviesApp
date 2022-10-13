//
//  Requestable.swift
//  MoviesApp
//
//  Created by Burak Güzey on 30.08.2022.
//

import Foundation

protocol Requestable {
    
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: Data? { get }
    var queryItems: [URLQueryItem] { get }
    
    
    func toURLRequest() -> URLRequest
    
}

extension Requestable {
    
    var baseURL: String {
        return ServiceConstants.BaseURLs.baseServiceURL
    }
    
    var queryItems: [URLQueryItem] {
        return  [
            URLQueryItem(name: ServiceConstants.Paths.apiKeyName, value: ServiceConstants.Paths.apiKey),
            URLQueryItem(name: ServiceConstants.Paths.page, value: ServiceConstants.Paths.defaultPage),
            URLQueryItem(name: ServiceConstants.Paths.lang, value: ServiceLanguageManager.currentLanguage())
        ]
    }
    
    func toURLRequest() -> URLRequest {
        
        let request: URLRequest
        var components = URLComponents()
        components.scheme = ServiceConstants.BaseURLs.baseScheme
        components.host = ServiceConstants.BaseURLs.baseServiceURL
        components.path = path
        components.queryItems = queryItems
        
        let urlRequest = components.url
        request = URLRequest(url: urlRequest!)
        
        return request
        
    }
}
