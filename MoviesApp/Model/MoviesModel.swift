//
//  MoviesModel.swift
//  MoviesApp
//
//  Created by Burak Güzey on 12.07.2022.
//

import Foundation

struct MoviesModel {
    let movieId: Int
    let movieName: String
    let movieReleaseDate: String
    let ratingOfMovie: Float
    let posterPhoto: String
}

struct MoviesModel2 {
    let idList: [Int]
    let nameList: [String]
    let releasedateList: [String]
    let ratingList: [String]
    let posterPath: [String]
}
