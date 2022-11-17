//
//  ReviewsViewController.swift
//  MoviesApp
//
//  Created by Burak Güzey on 17.11.2022.
//

import Foundation
import UIKit

class ReviewsViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var reviewsTableView: UITableView!
    
    let movieService = MovieService()
    
    var reviews: [Review] = []
    
    var movieId: Int?
    var pageString = ServiceConstants.Paths.defaultPage
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reviewsTableView.delegate = self
        reviewsTableView.dataSource = self
        
        reviewsTableView.rowHeight = 500
        
        reviewsTableView.register(UINib(nibName: String(describing: ReviewTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: ReviewTableViewCell.self))
        
        if let id = movieId {
        movieService.getReviews(id: id, page: pageString) { result in
            switch result {
            case.success(let response):
                self.reviews = response.results ?? []
                self.reviewsTableView.reloadData()
            case.failure(let error):
                print(error)
                }
            }
        } else {
            print("id not received")
        }
    }
}

extension ReviewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ReviewTableViewCell.self), for: indexPath) as! ReviewTableViewCell
        cell.configure(review: reviews[indexPath.row])
        return cell
    }
}
