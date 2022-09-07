//
//  DetailViewController.swift
//  MoviesApp
//
//  Created by Burak Güzey on 23.08.2022.
//

import Foundation
import UIKit

class DetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet weak var genresCollectionView: UICollectionView!
    @IBOutlet weak var revenueValueLabel: UILabel!
    @IBOutlet weak var budgetValueLabel: UILabel!
    @IBOutlet weak var overviewTextLabel: UILabel!
    @IBOutlet weak var runTimeLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var budgetLabel: UILabel!
    @IBOutlet weak var homepageLabel: UILabel!
    @IBOutlet weak var castCollectionView: UICollectionView!
    @IBOutlet weak var revenueLabel: UILabel!
    @IBOutlet weak var homePageTextLabel: UILabel!
    
    var movieId: Int?
    
    private var movieService = MovieService()
    private var movieDetail: MovieDetail? {
        didSet {
            updateUI()
        }
    }
    private var cast: [Cast] = []
    private var genres: [Genres] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let id = movieId {
            movieService.getMovieDetail(id: id) { result in
                switch result {
                case .success(let movie):
                    self.movieDetail = movie
                    self.genres = movie.genres ?? []
                    self.genresCollectionView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
            movieService.getAllCast(id: id) { result in
                switch result {
                case .success(let response):
                    self.cast = response.cast
                    self.castCollectionView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        } else {
            let alertVC = UIAlertController(title: "Error", message: "Not Found", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "Ok", style: .default) { action in
                self.navigationController?.popViewController(animated: true)
            }
            alertVC.addAction(okButton)
            self.present(alertVC, animated: true)
        }
        
        castCollectionView.dataSource = self
        castCollectionView.delegate = self
        
        genresCollectionView.dataSource = self
        genresCollectionView.delegate = self
        
        
        castCollectionView.register(UINib(nibName: "CastCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CastCollectionViewCell")
        genresCollectionView.register(UINib(nibName: "GenresCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GenresCollectionViewCell")
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == castCollectionView {
            return cast.count
        }
        else {
            return genres.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == castCollectionView {
            let castCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CastCollectionViewCell", for: indexPath) as! CastCollectionViewCell
            castCell.configure(cast: cast[indexPath.row])
            return castCell
        }
        else {
            let genresCell = collectionView.dequeueReusableCell(withReuseIdentifier: "GenresCollectionViewCell", for: indexPath) as! GenresCollectionViewCell
            genresCell.configure(genres: genres[indexPath.row])
            return genresCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

            if let castDetailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: CastDetailViewController.self)) as? CastDetailViewController {
                castDetailVC.castID = cast[indexPath.row].id!
                self.navigationController?.pushViewController(castDetailVC, animated: true)
            }
        }
    
    func updateUI() {
        
        let (h, m) = minutesToHoursMinutes((movieDetail?.runtime)!)
        let (rev, bud) = amountInMs(rev: (movieDetail?.revenue)!, bud: (movieDetail?.budget)!)
        let budgetString = "\(bud)M $"
        let revenueString = "\(rev)M $"
        let runTimeString = "\(h)h \(m)m"
        nameLabel.text = movieDetail?.title
        releaseDateLabel.text = movieDetail?.releaseDate
        overviewTextLabel.text = movieDetail?.overview
        runTimeLabel.text = runTimeString
        budgetValueLabel.text = budgetString
        revenueValueLabel.text = revenueString
        homePageTextLabel.text = movieDetail?.homepage
        
        if let imagePath = movieDetail?.posterPath {
            let imageString = ServiceConstants.baseImageURL + imagePath
            let urlStringImage = URL(string: imageString)
            movieImageView.kf.setImage(with: urlStringImage)
        } else {
            movieImageView.image = #imageLiteral(resourceName: "NO PHOTO")
        }
    }
    
    func minutesToHoursMinutes(_ mins: Int) -> (Int, Int) {
        return (mins / CalculationConstants.minsInAnHour, (mins % CalculationConstants.minsInAnHour))
    }
    
    func amountInMs(rev: Int, bud: Int) -> (Int, Int) {
        return (rev/CalculationConstants.million, bud/CalculationConstants.million)
    }
}



