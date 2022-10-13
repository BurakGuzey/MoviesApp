//
//  CastCollectionViewCell.swift
//  MoviesApp
//
//  Created by Burak Güzey on 30.08.2022.
//

import UIKit

class CastCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var castImageView: UIImageView!
    @IBOutlet weak var castNameLabel: UILabel!
    @IBOutlet weak var characterNameLabel: UILabel!
    
    func configure(cast: Cast) {
        castNameLabel.text = cast.name
        characterNameLabel.text = cast.character
        let urlString = URL(string: "https://image.tmdb.org/t/p/w500/qCpZn2e3dimwbryLnqxZuI88PTi.jpg")
        castImageView.kf.setImage(with: urlString)
    }
}
