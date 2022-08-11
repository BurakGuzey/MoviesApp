//
//  File.swift
//  MoviesApp
//
//  Created by Burak Güzey on 2.07.2022.
//

import Foundation
import UIKit

class DetailPageController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var CastCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension DetailPageController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CastCell", for: indexPath) as! CastCollectionViewCell
        return cell
    }
}
