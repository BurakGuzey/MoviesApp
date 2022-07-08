//
//  OverviewCell.swift
//  MoviesApp
//
//  Created by Burak Güzey on 5.07.2022.
//

import UIKit

class OverviewCell: UITableViewCell {

    @IBOutlet weak var overview: UILabel!
    @IBOutlet weak var overviewText: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
