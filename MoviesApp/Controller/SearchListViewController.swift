//
//  SearchListViewController.swift
//  MoviesApp
//
//  Created by Burak Güzey on 15.09.2022.
//

import Foundation
import UIKit

class SearchListViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchListTableView: UITableView!
    
    private var movieService = MovieService()
    private var movies: [Movie] = []
    
    private var pageNum = 1 
    private var pageString = ServiceConstants.Paths.defaultPage
    
    var textOnSearchBar = String()
    
    let EmptyLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 400, height: 21))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchListTableView.delegate = self
        searchListTableView.dataSource = self
        
        searchListTableView.register(UINib(nibName: String(describing: SearchListTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: SearchListTableViewCell.self))
        
        searchListTableView.rowHeight = 94
        
        EmptyLabel.center = CGPoint(x: 200, y: 450)
        EmptyLabel.textAlignment = .center
        EmptyLabel.text = "Search to View The Movies".localized()
        
        self.view.addSubview(EmptyLabel)
        
        searchBar.placeholder = "Search".localized()
    }
}

extension SearchListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SearchListTableViewCell.self), for: indexPath) as! SearchListTableViewCell
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
       
        if indexPath.row == movies.count - 1 {
            loadMoreSearchedMovies()
            searchListTableView.reloadData()
        }
    }
}

extension SearchListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if let text = searchBar.text {
            
            EmptyLabel.isHidden = true
            searchListTableView.isHidden = false
            
            textOnSearchBar = text
            
            searchedMovies(text: text)
            searchListTableView.reloadData()
            
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
    
    func loadMoreSearchedMovies() {
        pageNum = pageNum + 1
        pageString = String(pageNum)
        movieService.getSearchedMovies(text: textOnSearchBar) { result in
            switch result {
            case.success(let response):
                self.movies = (self.movies + (response.results ?? []))
                self.searchListTableView.reloadData()
            case.failure(let error):
                print(error)
            }
        }
    }
}
