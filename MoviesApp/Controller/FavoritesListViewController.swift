//
//  FavoritesListViewController.swift
//  MoviesApp
//
//  Created by Burak Güzey on 13.10.2022.
//

import Foundation
import UIKit

class FavoritesListViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var favoritesTableView: UITableView!
    
    private var favorites: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favoritesTableView.delegate = self
        favoritesTableView.dataSource = self
        
        favoritesTableView.register(UINib(nibName: String(describing: FavoritesTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: FavoritesTableViewCell.self))
        
        favoritesTableView.rowHeight = 94
        
    }
}

extension FavoritesListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FavoritesTableViewCell.self), for: indexPath) as! FavoritesTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: DetailViewController.self)) as? DetailViewController {
            detailVC.movieId = 0
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
        favoritesTableView.deselectRow(at: indexPath, animated: true)
    }
}
