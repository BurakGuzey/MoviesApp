//
//  CastModel.swift
//  MoviesApp
//
//  Created by Burak Güzey on 10.08.2022.
//

import Foundation

struct CastModel {
    let castName: String
    let castProfilePath: String
    let castCharacter: String
}

struct CastListModel: Codable {
    let castNameList: [String]
    let profilepathList: [String]
    let characterList: [String]
}
