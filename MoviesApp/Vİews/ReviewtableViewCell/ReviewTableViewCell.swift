//
//  ReviewTableViewCell.swift
//  MoviesApp
//
//  Created by Burak Güzey on 17.11.2022.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {

    @IBOutlet weak var contentText: UILabel!
    @IBOutlet weak var authorName: UILabel!
    
    func configure(review: Review) {
        
        authorName.text = review.author
        contentText.text = review.content
        
    }
}
