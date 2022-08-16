//
//  File.swift
//  MoviesApp
//
//  Created by Burak Güzey on 2.07.2022.
//

import Foundation
import UIKit

class DetailPageController: UIViewController {
    
    var moviesManager = MoviesManager()
    var movieListController = MovieListController()
    
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var runTimeLabel: UILabel!
    @IBOutlet weak var overviewText: UILabel!
    @IBOutlet weak var budgetLabel: UILabel!
    @IBOutlet weak var revenueLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var genre1: UILabel!
    @IBOutlet weak var castCollectionView: UICollectionView!
    
    var name = String()
    var poster = UIImage()
    var releaseDate = String()
    var runTime = Int()
    var revenue = Int()
    var overview = String()
    var budget = Int()
    var genres = [String]()
    var castNamePass = String()
    var characterNamePass = String()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        castCollectionView.dataSource = self
        castCollectionView.delegate = self
        
        castCollectionView.register(UINib(nibName: "CastCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CastCell")
        
        
        let (h, m) = minutesToHoursMinutes(runTime)
        let (revenueInM, budgetInM) = amountInMs(rev: revenue, bud: budget)
        
        releaseDateLabel.text = releaseDate
        budgetLabel.text = "\(String(budgetInM))M $"
        revenueLabel.text = "\(String(revenueInM))M $"
        movieName.text = name
        moviePoster.image = poster
        overviewText.text = overview
        runTimeLabel.text = "\(String(h))h \(String(m))m"
    }
}

extension DetailPageController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CastCell", for: indexPath) as! CastCollectionViewCell
        
        cell.castName.text = castNamePass
        cell.characterName.text = characterNamePass
        return cell
    }
}
extension DetailPageController {
    func minutesToHoursMinutes(_ mins: Int) -> (Int, Int) {
        return (mins / 60, (mins % 60))
    }
    func amountInMs(rev: Int, bud: Int) -> (Int, Int) {
        return (rev/1000000, bud/1000000)
    }
}


