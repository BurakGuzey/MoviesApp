//
//  MovieDetail.swift
//  MoviesApp
//
//  Created by Burak Güzey on 29.08.2022.
//

import Foundation

struct MovieDetail: Codable, Equatable {
    static func == (lhs: MovieDetail, rhs: MovieDetail) -> Bool {
        return lhs.id == rhs.id
    }
    
    
    let id: Int?
    let title: String?
    let releaseDate: String?
    let voteAverage: Float?
    let posterPath: String?
    let budget: Int?
    let revenue: Int?
    let homepage: String?
    let genres: [Genres]?
    let runtime: Int?
    let overview: String?
    
}

struct Genres: Codable {
    
    let name: String?

}
