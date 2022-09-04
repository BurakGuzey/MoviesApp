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
    
    @IBOutlet weak var listTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listTableView.dataSource = self
        listTableView.delegate = self
        listTableView.register(UINib(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier: "ListTableViewCell")
        
        listTableView.rowHeight = 94
        
        movieService.getAllMovies { result in
            switch result {
            case.success(let response):
                self.movie = response.results ?? []
                self.listTableView.reloadData()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath) as! ListTableViewCell
        cell.configure(movie: movie[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: DetailViewController.self)) as? DetailViewController {
            detailVC.movieId = movie[indexPath.row].id
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
        listTableView.deselectRow(at: indexPath, animated: true)
    }
}

