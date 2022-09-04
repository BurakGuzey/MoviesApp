//
//  MovieService.swift
//  MoviesApp
//
//  Created by Burak Güzey on 20.08.2022.
//

import Foundation

struct MovieService {
    
    private let moviesManager = MoviesManager()
    
    func getAllMovies(completion: @escaping (Result<AllMovies, NetworkError>) -> Void) {
        
        let urlRequest = URLRequest(url: URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=16e807f61c3e7c6382feff585c3859ad")!)
        moviesManager.performRequest(request: urlRequest, completion: completion)
        
    }
    
    func getMovieDetail(id: Int, completion: @escaping (Result<MovieDetail, NetworkError>) -> Void) {
        
        let urlRequest = URLRequest(url: URL(string: "https://api.themoviedb.org/3/movie/\(id)?api_key=16e807f61c3e7c6382feff585c3859ad")!)
        moviesManager.performRequest(request: urlRequest, completion: completion)
        
    }
    
    func getAllCast(id: Int, completion: @escaping (Result<AllCast, NetworkError>) -> Void) {
        
        let urlRequest = URLRequest(url: URL(string: "https://api.themoviedb.org/3/movie/\(id)/credits?api_key=16e807f61c3e7c6382feff585c3859ad")!)
        moviesManager.performRequest(request: urlRequest, completion: completion)
        
    }
    
    func getCastDetail(id: Int, completion: @escaping (Result<CastDetail, NetworkError>) -> Void) {
        
        let urlRequest = URLRequest(url: URL(string: "https://api.themoviedb.org/3/person/\(id)?api_key=16e807f61c3e7c6382feff585c3859ad")!)
        moviesManager.performRequest(request: urlRequest, completion: completion)
        
    }
    
    
}
