//
//  CastCollectionViewCell.swift
//  MoviesApp
//
//  Created by Burak Güzey on 30.08.2022.
//

import UIKit

class CastCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var castImageView: UIImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var castNameLabel: UILabel!
    
    func configure(cast: Cast) {
        
        castNameLabel.text = cast.name
        characterNameLabel.text = cast.character
        if let profilePath = cast.profilePath {
            let imageString = ServiceConstants.BaseURLs.baseImageURL + profilePath
            let urlStringImage = URL(string: imageString)
            castImageView.setImage(sourceURL: urlStringImage)
        } else {
            castImageView.image = #imageLiteral(resourceName: "NO PHOTO")
        }
    }

}
