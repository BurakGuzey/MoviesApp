//
//  File.swift
//  MoviesApp
//
//  Created by Burak Güzey on 2.07.2022.
//

import Foundation
import UIKit

class DetailPageController: UIViewController {
    
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var runTimeLabel: UILabel!
    @IBOutlet weak var overviewText: UILabel!
    @IBOutlet weak var budgetLabel: UILabel!
    @IBOutlet weak var revenueLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var castCollectionView: UICollectionView!

    var name = String()
    var poster = UIImage()
    var releaseDate = String()
    var runTime = String()
    var revenue = String()
    var overview = String()
    var budget = String()
    var genres = [String]()
    var castNamePass = String()
    var characterNamePass = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        castCollectionView.dataSource = self
        castCollectionView.delegate = self

        castCollectionView.register(UINib(nibName: "CastCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CastCell")
        
        
        
        movieName.text = name
        moviePoster.image = poster
        releaseDateLabel.text = releaseDate
        budgetLabel.text = budget
        revenueLabel.text = revenue
        overviewText.text = overview
        
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
