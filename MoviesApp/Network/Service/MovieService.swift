//
//  MovieService.swift
//  MoviesApp
//
//  Created by Burak Güzey on 20.08.2022.
//

import Foundation

struct MovieService {
    
    private let moviesManager = NetworkManager()
    
    func getAllMovies(completion: @escaping (Result<AllMovies, NetworkError>) -> Void) {
        
        moviesManager.performRequest(request: MovieRequest.allMovies, completion: completion)
        
    }
    
    func getMovieDetail(id: Int, completion: @escaping (Result<MovieDetail, NetworkError>) -> Void) {
        
        moviesManager.performRequest(request: MovieRequest.movieDetail(id: id), completion: completion)
        
    }
    
    func getAllCast(id: Int, completion: @escaping (Result<AllCast, NetworkError>) -> Void) {
        
        moviesManager.performRequest(request: CastRequest.allCast(id: id), completion: completion)
        
    }
    
    func getCastDetail(id: Int, completion: @escaping (Result<CastDetail, NetworkError>) -> Void) {
        
        moviesManager.performRequest(request: CastRequest.castDetail(id: id), completion: completion)
        
    }
    
    
}
