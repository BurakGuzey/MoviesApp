//
//  MovieDetail.swift
//  MoviesApp
//
//  Created by Burak Güzey on 29.08.2022.
//

import Foundation

struct MovieDetail: Codable {
    
    let id: Int?
    let title: String?
    let releaseDate: String?
    let voteAverage: Float?
    let posterPath: String?
    let budget: Int?
    let revenue: Int?
    let homePage: String?
    let genres: [Genres]?
    let runtime: Int?
    let overview: String?
    
}

struct Genres: Codable {
    let name: String?
}
