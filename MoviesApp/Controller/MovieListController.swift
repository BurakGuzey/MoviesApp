//
//  ViewController.swift
//  MoviesApp
//
//  Created by Burak Güzey on 1.07.2022.
//

import UIKit

class MovieListController: UIViewController, UITableViewDelegate {
    
    private var movieService = MovieService()
    private var movies: [Movie] = []
    
    var pageString = ServiceConstants.Paths.defaultPage
    var pageNum = 1
    
    @IBOutlet weak var movieListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieListTableView.dataSource = self
        movieListTableView.delegate = self
        
        movieListTableView.register(UINib(nibName: String(describing: MovieListTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: MovieListTableViewCell.self))
        
        movieListTableView.rowHeight = 94
        
        movieService.getAllMovies(page: pageString) { result in
            switch result {
            case.success(let response):
                self.movies = response.results ?? []
                self.movieListTableView.reloadData()
            case.failure(let error):
                print(error)
            }
        }
    }
}

extension MovieListController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MovieListTableViewCell.self), for: indexPath) as! MovieListTableViewCell
        cell.configure(movie: movies[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: DetailViewController.self)) as? DetailViewController {
            detailVC.movieId = movies[indexPath.row].id
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
        movieListTableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == movies.count - 1 {
            loadMoreMovies()
        }
    }
    
    func loadMoreMovies() {
        pageNum = pageNum + 1
        pageString = String(pageNum)
        movieService.getAllMovies(page: pageString) { [self] result in
            switch result {
            case.success(let response):
                self.movies = (movies + (response.results ?? [])) 
                self.movieListTableView.reloadData()
            case.failure(let error):
                print(error)
            }
        }
    }
}
