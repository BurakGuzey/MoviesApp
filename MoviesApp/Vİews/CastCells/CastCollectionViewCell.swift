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
    
    private var thirdPartyController = ThirdPartyControllers()
    
    func configure(cast: Cast) {
        
        castNameLabel.text = cast.name
        characterNameLabel.text = cast.character
        if let profilePath = cast.profilePath {
            let imageString = ServiceConstants.baseImageURL + profilePath
            let urlStringImage = URL(string: imageString)
            thirdPartyController.setImageKingfisher(imageView: castImageView, sourceURL: urlStringImage)
        } else {
            castImageView.image = #imageLiteral(resourceName: "NO PHOTO")
        }
    }

}
