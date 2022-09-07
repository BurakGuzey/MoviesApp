//
//  File.swift
//  MoviesApp
//
//  Created by Burak Güzey on 7.07.2022.
//

import Foundation

struct NetworkManager {
    
    private let session = URLSession.shared
    
    func performRequest<T: Codable>(request: Requestable, completion: @escaping (Result<T, NetworkError>) -> Void) {
        let task = session.dataTask(with: request.toURLRequest()) { (data, response, error) in
            DispatchQueue.main.async {
                if let safeData = data {
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let model = try decoder.decode(T.self, from: safeData)
                        completion(.success(model))
                    } catch {
                        completion(.failure(.decodingError))
                    }
                } else if error != nil {
                    completion(.failure(.netWorkError))
                } else {
                    completion(.failure(.unknownError))
                }
            }
        }
        task.resume()
    }
}

enum NetworkError: Error {
    
    case decodingError
    case netWorkError
    case unknownError
    
}
