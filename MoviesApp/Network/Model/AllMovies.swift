//
//  Movies.swift
//  MoviesApp
//
//  Created by Burak Güzey on 20.08.2022.
//

import Foundation

struct AllMovies: Codable {
    
    let results: [Movie]?
    let totalPages: Int?
    let totalResult: Int?
    
}

