//
//  ThirdPartyControllers.swift
//  MoviesApp
//
//  Created by Burak Güzey on 12.09.2022.
//

import Foundation
import Kingfisher
import UIKit


extension UIImageView {
    
    func setImage(sourceURL: URL?) {
        self.kf.setImage(with: sourceURL)
        
    }
}
