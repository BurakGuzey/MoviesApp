//
//  MovieService.swift
//  MoviesApp
//
//  Created by Burak Güzey on 20.08.2022.
//

import Foundation

struct MovieService {
    
    let apiKey = "16e807f61c3e7c6382feff585c3859ad"
     
    private let moviesManager = MoviesManager()
    
    func getAllMovies(completion: @escaping (Result<AllMovies, NetworkError>) -> Void) {
        
        let urlRequest = URLRequest(url: URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=16e807f61c3e7c6382feff585c3859ad")!)
        moviesManager.performRequest(request: urlRequest, completion: completion)
        
    }
    
    func getMovie(id: Int, completion: @escaping (Result<MovieDetail, NetworkError>) -> Void) {
        
        let urlRequest = URLRequest(url: URL(string: "https://api.themoviedb.org/3/movie/\(id)?api_key=16e807f61c3e7c6382feff585c3859ad")!)
        moviesManager.performRequest(request: urlRequest, completion: completion)
    
    }
    
    func getImage(posterPath: String, completion: @escaping (Result<Movie, NetworkError>) -> Void) {
        
        let urlRequest = URLRequest(url: URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")!)
        moviesManager.performRequest(request: urlRequest, completion: completion)

    }
    
}
