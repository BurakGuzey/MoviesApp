//
//  ThirdPartyControllers.swift
//  MoviesApp
//
//  Created by Burak Güzey on 12.09.2022.
//

import Foundation
import Kingfisher
import UIKit

struct ThirdPartyControllers {
    
    func setImageKingfisher(imageView: UIImageView, sourceURL: URL?) {
        imageView.kf.setImage(with: sourceURL)
    }
    
}
