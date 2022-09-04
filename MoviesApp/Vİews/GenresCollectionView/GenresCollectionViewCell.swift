//
//  GenresCollectionViewCell.swift
//  MoviesApp
//
//  Created by Burak Güzey on 30.08.2022.
//

import UIKit

class GenresCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var bubbleView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        bubbleView.layer.cornerRadius = 15
        
    }
    
    func configure(genres: Genres) {
        
        genresLabel.text = genres.name

    }
}
