//
//  RecommendationsCollectionView.swift
//  MoviesApp
//
//  Created by Burak Güzey on 29.09.2022.
//

import UIKit

class RecommendationsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var recommendationsNameLabel: UILabel!
    @IBOutlet weak var recommendationImageView: UIImageView!
    
    func configure(recommendations: Recommendation) {
        
        recommendationsNameLabel.text = recommendations.title
        
        if let profilePath = recommendations.posterPath {
            let imageString = ServiceConstants.BaseURLs.baseImageURL + profilePath
            let urlStringImage = URL(string: imageString)
            recommendationImageView.setImage(sourceURL: urlStringImage)
        } else {
            recommendationImageView.image = #imageLiteral(resourceName: "NO PHOTO")
        }
    }
    
}
