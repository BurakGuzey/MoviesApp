//
//  Movie.swift
//  MoviesApp
//
//  Created by Burak Güzey on 19.08.2022.
//

import Foundation

struct Movie: Codable {
    
    let id: Int?
    let title: String?
    let releaseDate: String?
    let voteAverage: Float?
    let posterPath: String?
    
}

