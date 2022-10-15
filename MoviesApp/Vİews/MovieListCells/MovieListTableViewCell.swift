//
//  ListTableViewCell.swift
//  MoviesApp
//
//  Created by Burak Güzey on 5.07.2022.
//

import UIKit
import Kingfisher

class MovieListTableViewCell: UITableViewCell {
    
    var movieListController = MovieListController()
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    @IBAction func favButton(_ sender: UIButton) {
        handleMarkAsFavorite()
    }

    
    func configure(movie: Movie) {
        let ratingString = String(movie.voteAverage!)
        
        nameLabel.text = movie.title
        releaseDateLabel.text = movie.releaseDate
        ratingLabel.text = ratingString
        if let imagePath = movie.posterPath {
            let imageString = ServiceConstants.BaseURLs.baseImageURL + imagePath
            let urlStringImage = URL(string: imageString)
            movieImage.setImage(sourceURL: urlStringImage)
        } else {
            movieImage.image = #imageLiteral(resourceName: "NO PHOTO")
        }
    }
    
    func handleMarkAsFavorite() {
        movieListController.someMethodIWantToCall(cell: self)
    }
}
