//
//  FavoritesListViewController.swift
//  MoviesApp
//
//  Created by Burak Güzey on 13.10.2022.
//

import Foundation
import UIKit

class FavoritesListViewController: UIViewController, UITableViewDelegate {
    
    private var movieService = MovieService()
    var favoritedMovies = [MovieDetail]()
    var favoritedMovieIdList = [Int]()
    var isFavorited: Bool?
    
    var nc = NotificationCenter.default
    
    @IBOutlet weak var favoritesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favoritesTableView.delegate = self
        favoritesTableView.dataSource = self
        
        favoritesTableView.register(UINib(nibName: String(describing: MovieListTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: MovieListTableViewCell.self))
        
        favoritesTableView.rowHeight = 94
        
        favoriteListUpdate()
        favoriteListUpload()
        
        nc.addObserver(self, selector:  #selector(favoriteButtonTapped), name: Notification.Name("FavoriteButtonTapped"), object: nil)
        
    }
}

extension FavoritesListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritedMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MovieListTableViewCell.self), for: indexPath) as! MovieListTableViewCell
        cell.configureDetail(movie: favoritedMovies[indexPath.row], isFavorited: isFavorited!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: DetailViewController.self)) as? DetailViewController {
            detailVC.movieId = favoritedMovies[indexPath.row].id
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
        favoritesTableView.deselectRow(at: indexPath, animated: true)
    }
    
    func favoriteListUpdate() {
        for movieId in FavoriteMovieManager.defaultManager.favoritedIdList {
            isFavorited = FavoriteMovieManager.defaultManager.checkMovieIsFavorited(id: movieId)
            if favoritedMovieIdList.contains(movieId) {
                var indexOfMovieToRemove = favoritedMovieIdList.index(of: movieId)!
                favoritedMovieIdList.remove(at: indexOfMovieToRemove)
            } else {
                favoritedMovieIdList.append(movieId)
            }
        }
    }
    
    func favoriteListUpload() {
        for movieId in FavoriteMovieManager.defaultManager.favoritedIdList {
        movieService.getMovieDetail(id: movieId) { result in
            switch result {
            case .success(let movie):
                        self.favoritedMovies.append(movie)
                        self.favoritesTableView.reloadData()
                print(self.favoritedMovies)
            case .failure(let error):
                print(error)
            }
        }
    }
        favoritedMovies = []
}
    
    @objc func favoriteButtonTapped() {
        FavoriteMovieManager.defaultManager.readFavoriteList()
        favoriteListUpdate()
        favoriteListUpload()
        favoritesTableView.reloadData()
    }
}
