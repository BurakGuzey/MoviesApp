//
//  DetailViewController.swift
//  MoviesApp
//
//  Created by Burak Güzey on 23.08.2022.
//

import Foundation
import UIKit

class DetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet weak var revenueValueLabel: UILabel!
    @IBOutlet weak var budgetValueLabel: UILabel!
    @IBOutlet weak var overviewTextLabel: UILabel!
    @IBOutlet weak var runTimeLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var budgetLabel: UILabel!
    @IBOutlet weak var homepageLabel: UILabel!
    @IBOutlet weak var castCollectionView: UICollectionView!
    @IBOutlet weak var revenueLabel: UILabel!
    
    var movieId: Int?
    
    private var movieService = MovieService()
    private var movieDetail: MovieDetail? {
        didSet {
            updateUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let id = movieId {
            movieService.getMovie(id: id) { result in
                switch result {
                case .success(let movie):
                    self.movieDetail = movie
                case .failure(let error):
                    print(error)
                }
            }
        } else {
            let alertVC = UIAlertController(title: "Error", message: "Not Found", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "Ok", style: .default) { action in
                self.navigationController?.popViewController(animated: true)
            }
            alertVC.addAction(okButton)
            self.present(alertVC, animated: true)
        }
        
        castCollectionView.dataSource = self
        castCollectionView.delegate = self
        
        castCollectionView.register(UINib(nibName: "CastCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CastCollectionViewCell")
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CastCollectionViewCell", for: indexPath) as! CastCollectionViewCell
        return cell
    }
    
    func updateUI() {
        let budgetString = "\((movieDetail?.budget)!)M $"
        let revenueString = "\((movieDetail?.revenue)!)M $"
        let runTimeString = "\((movieDetail?.runtime)!)"
        nameLabel.text = movieDetail?.title
        releaseDateLabel.text = movieDetail?.releaseDate
        overviewTextLabel.text = movieDetail?.overview
        runTimeLabel.text = runTimeString
        budgetValueLabel.text = budgetString
        revenueValueLabel.text = revenueString
        
    }

//    func minutesToHoursMinutes(_ mins: Int) -> (Int, Int) {
//        return (mins / 60, (mins % 60))
//    }
//    func amountInMs(rev: Int, bud: Int) -> (Int, Int) {
//        return (rev/1000000, bud/1000000)
//    }
    
}



