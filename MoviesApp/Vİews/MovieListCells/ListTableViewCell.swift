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
        if let imagePath = movie.posterPath {
            let imageString = Constants.baseImageURL + imagePath
            let urlStringImage = URL(string: imageString)
            movieImage.kf.setImage(with: urlStringImage)
        } else {
            movieImage.image = #imageLiteral(resourceName: "NO PHOTO")
        }
    }
}
