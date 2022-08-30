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
        let urlStringImage = URL(string: "https://image.tmdb.org/t/p/w500/jpurJ9jAcLCYjgHHfYF32m3zJYm.jpg")
        castImageView.kf.setImage(with: urlStringImage)
        
    }
    

}
