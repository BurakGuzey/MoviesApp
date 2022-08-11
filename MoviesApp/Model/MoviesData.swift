//
//  MoviesData.swift
//  MoviesApp
//
//  Created by Burak Güzey on 12.07.2022.
//

import Foundation
import UIKit

struct MoviesData: Codable {
    let results: [Results]
}

struct Results: Codable {
    let id: Int?
    let title: String?
    let release_date: String?
    let vote_average: Float?
    let poster_path: String?
}




