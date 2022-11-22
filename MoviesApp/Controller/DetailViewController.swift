//
//  DetailViewController.swift
//  MoviesApp
//
//  Created by Burak Güzey on 23.08.2022.
//

import Foundation
import UIKit
import WebKit

class DetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet weak var favoriteButton: UIButton!
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
    @IBOutlet weak var homepageButtonOutlet: UIButton!
    @IBOutlet weak var recommendationsCollectionView: UICollectionView!
    @IBOutlet weak var recommendationsLabel: UILabel!
    @IBOutlet weak var author1: UILabel!
    @IBOutlet weak var content2: UILabel!
    @IBOutlet weak var content1: UILabel!
    @IBOutlet weak var author2: UILabel!
    @IBOutlet weak var viewAllReviews: UIButton!
    
    @IBAction func homepageButton(_ sender: UIButton) {
        if let homepageVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: HomepageViewController.self)) as? HomepageViewController {
            homepageVC.homepageString = movieDetail?.homepage
            self.present(homepageVC, animated: true)
        }
    }
    
    @IBAction func viewAllReviews(_ sender: UIButton) {
        if let reviewVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: ReviewsViewController.self)) as? ReviewsViewController {
            reviewVC.movieId = movieId
            self.present(reviewVC, animated: true)
        }
    }
    
    var movieId: Int?
    var isFavorited: Bool?
    var movieDic = [String: Int]()
    
    @IBAction func favoriteButton(_ sender: UIButton) {
        nc.post(name: .updatedFavoriteList , object: nil, userInfo: movieDic)
        if let id = movieId {
            FavoriteMovieManager.defaultManager.editFavoriteList(id: id)
        }
        favoriteButton.tintColor = (favoriteButton.tintColor != .blue) ? .blue : .darkGray
    }
    
    private var movieService = MovieService()
    private var movieDetail: MovieDetail? {
        didSet {
            updateUI(isFavorited: isFavorited!)
        }
    }
    
    private var casts: [Cast] = []
    private var genres: [Genres] = []
    private var recommendations: [Recommendation] = []
    private var reviews: [Review] = []
    
    var pageString = ServiceConstants.Paths.defaultPage
    var pageNum = 1
    
    var nc = NotificationCenter.default
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overviewLabel.text = "Overview".localized()
        budgetLabel.text = "Budget".localized()
        revenueLabel.text = "Revenue".localized()
        homepageLabel.text = "Home Page".localized()
        recommendationsLabel.text = "Recommendations".localized()
        viewAllReviews.titleLabel?.text = "Show All Reviews".localized()

        
        if let id = movieId {
            
            movieDic = ["movie": id]
            
            movieService.getReviews(id: id, page: pageString) { result in
                switch result {
                case.success(let response):
                    self.reviews = response.results ?? []
                case.failure(let error):
                    print(error)
                }
            }
            
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
            movieService.getRecommendations(id: id, page: pageString) { result in
                switch result {
                case .success(let response):
                    self.recommendations = response.results ?? []
                    self.recommendationsCollectionView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
            movieService.getAllCast(id: id) { result in
                switch result {
                case .success(let response):
                    self.casts = response.cast
                    self.castCollectionView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
            
            isFavorited = FavoriteMovieManager.defaultManager.checkMovieIsFavorited(id: id)
            
        } else {
            let alertVC = UIAlertController(title: "Error".localized(), message: "Not Found".localized(), preferredStyle: .alert)
            let okButton = UIAlertAction(title: "ok".localized(), style: .default) { action in
                self.navigationController?.popViewController(animated: true)
            }
            alertVC.addAction(okButton)
            self.present(alertVC, animated: true)
        }
        
        nc.addObserver(self, selector:  #selector(updatedFavoritedList), name: .updatedFavoriteList, object: nil)
        
        castCollectionView.dataSource = self
        castCollectionView.delegate = self
        
        genresCollectionView.dataSource = self
        
        recommendationsCollectionView.dataSource = self
        recommendationsCollectionView.delegate = self
        
        castCollectionView.register(UINib(nibName: String(describing: CastCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: CastCollectionViewCell.self))
        genresCollectionView.register(UINib(nibName: String(describing: GenresCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: GenresCollectionViewCell.self))
        recommendationsCollectionView.register(UINib(nibName: String(describing: RecommendationsCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: RecommendationsCollectionViewCell.self))
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == castCollectionView {
            return casts.count
        } else if collectionView == genresCollectionView {
            return genres.count
        } else {
            return recommendations.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == castCollectionView {
            let castCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CastCollectionViewCell.self), for: indexPath) as! CastCollectionViewCell
            castCell.configure(cast: casts[indexPath.row])
            return castCell
        } else if collectionView == genresCollectionView {
            let genresCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: GenresCollectionViewCell.self), for: indexPath) as! GenresCollectionViewCell
            genresCell.configure(genres: genres[indexPath.row])
            return genresCell
        } else {
            let recommendationsCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: RecommendationsCollectionViewCell.self), for: indexPath) as! RecommendationsCollectionViewCell
            recommendationsCell.configure(recommendations: recommendations[indexPath.row])
            return recommendationsCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == castCollectionView {
            if let castDetailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: CastDetailViewController.self)) as? CastDetailViewController {
                castDetailVC.castID = casts[indexPath.row].id!
                self.navigationController?.pushViewController(castDetailVC, animated: true)
            }
        } else {
            if let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: DetailViewController.self)) as? DetailViewController {
                detailVC.movieId = recommendations[indexPath.row].id
                self.navigationController?.pushViewController(detailVC, animated: true)
            }
        }
    }
    
    func updateUI(isFavorited: Bool) {
        
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
        
        
        if reviews.count >= 2 {
            
            author1.isHidden = false
            author2.isHidden = false
            content1.isHidden = false
            content2.isHidden = false
            viewAllReviews.isHidden = false
            
            author1.text = reviews[0].author
            author2.text = reviews[1].author
            content1.text = reviews[0].content
            content2.text = reviews[1].content
            
        } else if reviews.count == 1 {
            
            author1.text = reviews[0].author
            content1.text = reviews[0].content
            
            author2.isHidden = true
            content2.isHidden = true
            viewAllReviews.isHidden = true
            
        } else {
            
            author1.isHidden = true
            author2.isHidden = true
            content1.isHidden = true
            content2.isHidden = true
            viewAllReviews.isHidden = true
            
        }
        
        if let imagePath = movieDetail?.posterPath {
            let imageString = ServiceConstants.BaseURLs.baseImageURL + imagePath
            let urlStringImage = URL(string: imageString)
            movieImageView.setImage(sourceURL: urlStringImage)
        } else {
            movieImageView.image = #imageLiteral(resourceName: "NO PHOTO")
        }

        favoriteButton.tintColor = isFavorited == false ? .darkGray : .blue

    }
    
    func loadMoreMovies(id: Int) {
        pageNum = pageNum + 1
        movieService.getRecommendations(id: id, page: pageString) { result in
            switch result {
            case.success(let response):
                self.recommendations = (self.recommendations + (response.results ?? [] ))
                self.recommendationsCollectionView.reloadData()
            case.failure(let error):
                print(error)
            }
        }
    }
    
    @objc func updatedFavoritedList(id: Int) {
        FavoriteMovieManager.defaultManager.readFavoriteList()
    }
    

    
    func minutesToHoursMinutes(_ mins: Int) -> (Int, Int) {
        return (mins / CalculationConstants.minsInAnHour, (mins % CalculationConstants.minsInAnHour))
    }
    
    func amountInMs(rev: Int, bud: Int) -> (Int, Int) {
        return (rev/CalculationConstants.million, bud/CalculationConstants.million)
    }
    
    struct CalculationConstants {
        
        static let minsInAnHour = 60
        static let million = 1000000
        
    }
}
