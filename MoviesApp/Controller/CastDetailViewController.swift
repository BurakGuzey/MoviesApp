//
//  CastDetailViewController.swift
//  MoviesApp
//
//  Created by Burak Güzey on 5.09.2022.
//

import Foundation
import UIKit
import Kingfisher

class CastDetailViewController: UIViewController {
    
    @IBOutlet weak var castNameLabel: UILabel!
    @IBOutlet weak var biographyLabel: UILabel!
    @IBOutlet weak var placeOfBirth: UILabel!
    @IBOutlet weak var birhtdayLabel: UILabel!
    @IBOutlet weak var biographyHeadlineLabel: UILabel!
    @IBOutlet weak var castImageView: UIImageView!
    @IBOutlet weak var placeOfBirthHeadline: UILabel!
    @IBOutlet weak var birthDeathDayHeadline: UILabel!
    @IBOutlet weak var deathDayLabel: UILabel!
    
    var castID: Int?
    
    private var movieService = MovieService()
    private var castDetail: CastDetail? {
        didSet {
            updateCastList()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let id = castID {
            movieService.getCastDetail(id: id) { result in
                switch result {
                case .success(let cast):
                    self.castDetail = cast
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func updateCastList() {
        
        castNameLabel.text = castDetail?.name
        biographyLabel.text = castDetail?.biography
        placeOfBirth.text = castDetail?.placeOfBirth
        birhtdayLabel.text = castDetail?.birthday
        if let deathday = castDetail?.deathday {
            deathDayLabel.text = "- \(deathday)"
        } else {
            birthDeathDayHeadline.text = "Birthday"
            deathDayLabel.text = ""
        }
        if let profilePath = castDetail?.profilePath {
            let urlString = URL(string: ServiceConstants.baseImageURL + profilePath)
            castImageView.kf.setImage(with: urlString)
        } else {
            castImageView.image = #imageLiteral(resourceName: "NO PHOTO")
        }
    }
}
