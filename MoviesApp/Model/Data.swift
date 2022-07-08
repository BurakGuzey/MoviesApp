//
//  File.swift
//  MoviesApp
//
//  Created by Burak Güzey on 7.07.2022.
//

import Foundation

struct MoviesData {
    let baseURL = "https://api.themoviedb.org/3"
    let apiKey = "16e807f61c3e7c6382feff585c3859ad"
    
    func getPopularMovies() {
    let urlString = "\(baseURL)/movie/popular?apikey=\(apiKey)"
    }
}
