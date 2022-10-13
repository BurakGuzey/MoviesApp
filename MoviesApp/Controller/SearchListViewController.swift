//
//  SearchListViewController.swift
//  MoviesApp
//
//  Created by Burak Güzey on 15.09.2022.
//

import Foundation
import UIKit

class SearchListViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var searchListTableView: UITableView!
    
    private var movieService = MovieService()
    private var movies: [Movie] = []
    
    let EmptyLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 400, height: 21))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchListTableView.delegate = self
        searchListTableView.dataSource = self
        searchListTableView.register(UINib(nibName: String(describing: SearchListTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: SearchListTableViewCell.self))
        
        searchListTableView.rowHeight = 94
        
        EmptyLabel.center = CGPoint(x: 200, y: 450)
        EmptyLabel.textAlignment = .center
        EmptyLabel.text = "Search to View The Movies"
        
        self.view.addSubview(EmptyLabel)
        
    }
}

extension SearchListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchListTableViewCell", for: indexPath) as! SearchListTableViewCell
        cell.configure(movie: movies[indexPath.row])
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: DetailViewController.self)) as? DetailViewController {
            detailVC.movieId = movies[indexPath.row].id
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
        searchListTableView.deselectRow(at: indexPath, animated: true)
    }
}

extension SearchListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if let text = searchBar.text {
            
            EmptyLabel.isHidden = true
            
            searchedMovies(text: text)
            
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            
            searchListTableView.isHidden = true
            EmptyLabel.isHidden = false
            
        }
    }
    
    func searchedMovies(text: String) {
        movieService.getSearchedMovies(text: text) { result in
            switch result {
            case.success(let response):
                self.movies = response.results ?? []
                self.searchListTableView.reloadData()
            case.failure(let error):
                print(error)
            }
        }
    }
}
