//
//  ViewController.swift
//  MoviesApp
//
//  Created by Burak Güzey on 1.07.2022.
//

import UIKit

class MovieListController: UIViewController, UITableViewDelegate {
    
    
    var moviesManager = MoviesManager(pageNum: 1, lang: "en")
    var nameList = [String]()
    var realesedateList = [String]()
    var ratingList = [String]()
    @IBOutlet weak var listTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listTableView.dataSource = self
        listTableView.delegate = self
        moviesManager.delegate = self
        
        listTableView.register(UINib(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        
        self.listTableView.rowHeight = 94
        
        moviesManager.getPopularMovies()
        
    }
}

extension MovieListController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! ListTableViewCell
        cell.movieName.text = nameList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        navigationController?.pushViewController(DetailPageController(), animated: true)
    }
}

extension MovieListController: MoviesManagerDelegate {
    func didUploadMovieList(moviesList: MoviesModel2) {
        DispatchQueue.main.async {
            self.nameList = moviesList.nameList
            self.realesedateList = moviesList.releasedateList
            self.ratingList = moviesList.ratingList
            self.listTableView.reloadData()
        }
    }
}
