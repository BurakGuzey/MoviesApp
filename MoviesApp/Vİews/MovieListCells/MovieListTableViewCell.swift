//
//  ListTableViewCell.swift
//  MoviesApp
//
//  Created by Burak Güzey on 5.07.2022.
//

import UIKit
import Kingfisher

protocol FavoriteMovieDelegate: AnyObject {
    func favoriteMovie(id: Int)
}

class MovieListTableViewCell: UITableViewCell {
    
    var movieId = Int()
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var favButton: UIButton!
        
    @IBAction func favButton(_ sender: UIButton) {
        handleMarkAsFavorite()
    }
    
    weak var favoriteDelegate: FavoriteMovieDelegate?
    
    func configure(movie: Movie, isFavorited: Bool) {
        
        let ratingString = String(movie.voteAverage!)
        
        nameLabel.text = movie.title
        releaseDateLabel.text = movie.releaseDate
        ratingLabel.text = ratingString
        if let id = movie.id {
            movieId = id
        }
        if let imagePath = movie.posterPath {
            let imageString = ServiceConstants.BaseURLs.baseImageURL + imagePath
            let urlStringImage = URL(string: imageString)
            movieImage.setImage(sourceURL: urlStringImage)
        } else {
            movieImage.image = #imageLiteral(resourceName: "NO PHOTO")
        }
        
        favButton.tintColor = isFavorited == false ? .darkGray : .blue
    }
    
    func configureDetail(movie: MovieDetail, isFavorited: Bool) {
        
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
        
        favButton.tintColor = isFavorited == false ? .darkGray : .blue
    }
    
    func handleMarkAsFavorite() {
        favoriteDelegate?.favoriteMovie(id: movieId)
        favButton.tintColor = (favButton.tintColor != .blue) ? .blue : .darkGray
    }
}


