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
    var movieIdTapped = Int()
    var movieToRemoveOrAdd: MovieDetail?
    
    var nc = NotificationCenter.default
    
    @IBOutlet weak var favoritesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favoritesTableView.delegate = self
        favoritesTableView.dataSource = self
        
        favoritesTableView.register(UINib(nibName: String(describing: MovieListTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: MovieListTableViewCell.self))
        
        favoritesTableView.rowHeight = 94
        
        uploadFavoriteList()
        
        nc.addObserver(self, selector:  #selector(favoriteButtonTapped), name: .updatedFavoriteList, object: nil)
        
    }
}

extension FavoritesListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritedMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MovieListTableViewCell.self), for: indexPath) as! MovieListTableViewCell
        cell.configureFavoriteList(movie: favoritedMovies[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: DetailViewController.self)) as? DetailViewController {
            detailVC.movieId = favoritedMovies[indexPath.row].id
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
        favoritesTableView.deselectRow(at: indexPath, animated: true)
    }
    
    func uploadFavoriteList() {
        for movieId in FavoriteMovieManager.defaultManager.favoritedIdList {
            movieService.getMovieDetail(id: movieId) { result in
                switch result {
                case .success(let movie):
                    self.favoritedMovies.append(movie)
                    self.favoritesTableView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func updateFavoriteList() {
        
        movieService.getMovieDetail(id: movieIdTapped) { result in
            switch result {
            case .success(let movie):
                self.movieToRemoveOrAdd = movie
                if self.favoritedMovies.contains(self.movieToRemoveOrAdd!) {
                    if let indexOfMovieToRemoveOrAdd = self.favoritedMovies.firstIndex(of: self.movieToRemoveOrAdd!){
                        self.favoritedMovies.remove(at: indexOfMovieToRemoveOrAdd)
                        self.favoritesTableView.reloadData()
                        print("added")
                    }
                } else {
                    self.favoritedMovies.append(self.movieToRemoveOrAdd!)
                    self.favoritesTableView.reloadData()
                    print("removed")
            }
            case .failure(let error):
                print(error)
            }
        }

}
    
    @objc func favoriteButtonTapped(notification: NSNotification) {
        
        if let movieTapped = notification.userInfo?["movie"] as? Int {
            FavoriteMovieManager.defaultManager.readFavoriteList()
            movieIdTapped = movieTapped
            updateFavoriteList()
        }
    }
}
