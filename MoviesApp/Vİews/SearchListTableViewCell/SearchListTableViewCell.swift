//
//  SearchListTableViewCell.swift
//  MoviesApp
//
//  Created by Burak Güzey on 15.09.2022.
//

import UIKit

class SearchListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    
    func configure(movie: Movie) {
        
        let ratingString = String(movie.voteAverage!)
        
        nameLabel.text = movie.title
        releaseDateLabel.text = movie.releaseDate
        ratingLabel.text = ratingString
        if let imagePath = movie.posterPath {
            let imageString = ServiceConstants.BaseURLs.baseImageURL + imagePath
            let urlStringImage = URL(string: imageString)
            movieImageView.setImage(sourceURL: urlStringImage)
        } else {
            movieImageView.image = #imageLiteral(resourceName: "NO PHOTO")
        }
    }

}
