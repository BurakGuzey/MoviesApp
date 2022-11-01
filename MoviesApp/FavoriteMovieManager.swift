//
//  FavoriteMovieManager.swift
//  MoviesApp
//
//  Created by Burak Güzey on 21.10.2022.
//

import Foundation
import SwiftUI

class FavoriteMovieManager {
    
    let defaults = UserDefaults.standard
    
    static let defaultManager = FavoriteMovieManager()
    
    private init() {
        readFavoriteList()
    }
    
    var favoritedIdList = [Int]()
    
    
    func saveData() {
        defaults.set(favoritedIdList, forKey: "FavoritedMovieList")
    }
    
    func editFavoriteList(id: Int) {
        if favoritedIdList.contains(id) {
            var indexOfMovieToRemove = favoritedIdList.index(of: id)!
            favoritedIdList.remove(at: indexOfMovieToRemove)
        } else {
            favoritedIdList.append(id)
        }
    }
    
    func readFavoriteList() {
        if let favoritedMovies = defaults.array(forKey: "FavoritedMovieList") as? [Int] {
        favoritedIdList = favoritedMovies
        }
    }
    
    func checkMovieIsFavorited(id: Int) -> Bool {
        
        if favoritedIdList.contains(id) {
            return true
        } else {
            return false
        }
    }
}
