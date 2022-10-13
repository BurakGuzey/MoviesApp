//
//  SearchedMovies.swift
//  MoviesApp
//
//  Created by Burak Güzey on 3.10.2022.
//

import Foundation

import Foundation

struct SearchedMovies: Codable {
    
    let results: [Movie]?
    let totalPages: Int?
    let totalResult: Int?
    
}
