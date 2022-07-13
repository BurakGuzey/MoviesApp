//
//  MoviesData.swift
//  MoviesApp
//
//  Created by Burak Güzey on 12.07.2022.
//

import Foundation

struct MoviesData: Decodable {
    let result: [Result]
}

struct Result: Decodable {
    let id: Int
    let title: String
    let release_date: String
    let vote_average: Float
}
