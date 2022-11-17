//
//  MovieService.swift
//  MoviesApp
//
//  Created by Burak Güzey on 20.08.2022.
//

import Foundation

struct MovieService {
    
    private let networkManager = NetworkManager()
    
    func getAllMovies(page: String, completion: @escaping (Result<AllMovies, NetworkError>) -> Void) {
        
        networkManager.performRequest(request: MovieRequest.allMovies(pageString: page), completion: completion)
        
    }
    
    func getMovieDetail(id: Int, completion: @escaping (Result<MovieDetail, NetworkError>) -> Void) {
        
        networkManager.performRequest(request: MovieRequest.movieDetail(id: id), completion: completion)
        
    }
    
    func getAllCast(id: Int, completion: @escaping (Result<AllCasts, NetworkError>) -> Void) {
        
        networkManager.performRequest(request: CastRequest.allCast(id: id), completion: completion)
        
    }
    
    func getCastDetail(id: Int, completion: @escaping (Result<CastDetail, NetworkError>) -> Void) {
        
        networkManager.performRequest(request: CastRequest.castDetail(id: id), completion: completion)
        
    }
    
    func getSearchedMovies(text: String, completion: @escaping (Result<SearchedMovies, NetworkError>) -> Void) {
        
        networkManager.performRequest(request: SearchRequest.searchMovie(text: text), completion: completion)
        
    }
    
    func getRecommendations(id: Int, page: String, completion: @escaping (Result<AllRecommendations, NetworkError>) -> Void) {
        
        networkManager.performRequest(request: RecommendationRequest.allrecommendations(id: id, pageString: page), completion: completion)
        
    }
    
    func getReviews(id: Int, page: String, completion: @escaping (Result<AllReviews, NetworkError>) -> Void) {
        
        networkManager.performRequest(request: ReviewRequest.allReviewRequest(id: id), completion: completion)

    }
    
}
