//
//  ListTableViewCell.swift
//  MoviesApp
//
//  Created by Burak Güzey on 5.07.2022.
//

import UIKit
import Kingfisher

class ListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBAction func favButton(_ sender: UIButton) {
        print("added to fav list")
    }
    
    func configure(movie: Movie) {
        
        let ratingString = String(movie.voteAverage!)
        nameLabel.text = movie.title
        releaseDateLabel.text = movie.releaseDate
        ratingLabel.text = ratingString
        let urlStringImage = URL(string: "https://image.tmdb.org/t/p/w500/ujr5pztc1oitbe7ViMUOilFaJ7s.jpg")
        movieImage.kf.setImage(with: urlStringImage)
        
    }
    
}

