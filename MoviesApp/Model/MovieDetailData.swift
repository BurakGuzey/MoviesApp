//
//  File.swift
//  MoviesApp
//
//  Created by Burak Güzey on 13.08.2022.
//

import Foundation

struct MovieDetailData: Codable {
    let budget: Int
    let homepage: String
    let revenue: Int
    let runtime: Int
    let genres: [Genres]
}

struct Genres: Codable {
    let name: String?
}


