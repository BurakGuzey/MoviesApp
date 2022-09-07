//
//  ViewController.swift
//  MoviesApp
//
//  Created by Burak Güzey on 1.07.2022.
//

import UIKit

class MovieListController: UIViewController, UITableViewDelegate {
    
    private var movieService = MovieService()
    private var movie: [Movie] = []
    
    @IBOutlet weak var movieListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieListTableView.dataSource = self
        movieListTableView.delegate = self
        movieListTableView.register(UINib(nibName: "MovieListTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieListTableViewCell")
        
        movieListTableView.rowHeight = 94
        
        movieService.getAllMovies { result in
            switch result {
            case.success(let response):
                self.movie = response.results ?? []
                self.movieListTableView.reloadData()
            case.failure(let error):
                print(error)
            }
        }
    }
}

extension MovieListController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movie.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieListTableViewCell", for: indexPath) as! MovieListTableViewCell
        cell.configure(movie: movie[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: DetailViewController.self)) as? DetailViewController {
            detailVC.movieId = movie[indexPath.row].id
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
        movieListTableView.deselectRow(at: indexPath, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (movieListTableView.contentSize.height-100-scrollView.frame.size.height) {
            print("fetch data")
        }
    }
}

