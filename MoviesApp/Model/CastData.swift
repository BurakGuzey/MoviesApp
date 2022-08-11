//
//  Cast Data.swift
//  MoviesApp
//
//  Created by Burak Güzey on 10.08.2022.
//

import Foundation

struct CastData: Codable {
    let cast: [Cast]
}

struct Cast: Codable {
    let name: String?
    let profile_path: String?
    let character: String?
}
