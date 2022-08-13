//
//  ViewController.swift
//  MoviesApp
//
//  Created by Burak Güzey on 1.07.2022.
//

import UIKit

class MovieListController: UIViewController, UITableViewDelegate {
    
    //MARK: - Variables
    
    var moviesManager = MoviesManager()
    var nameList = [String]()
    var realesedateList = [String]()
    var ratingList = [String]()
    var posterPathList = [String]()
    var imageList = [UIImage]()
    var imageUrlString = String()
    var overviewTextList = [String]()
    var idList = [Int]()
    
    var movieBudget = Int()
    var movieHomePage = String()
    var movieRevenue = Int()
    var movieRuntime = Int()
    var detailUrlString = String()
    var genreList = [String]()
    
    
    var castNameList = [String]()
    var castProfilePathList = [String]()
    var castPhotoList = [UIImage]()
    var characterNameList = [String]()
    
    @IBOutlet weak var listTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listTableView.dataSource = self
        listTableView.delegate = self
        
        listTableView.register(UINib(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        
        getPopularMovies()
        
        self.listTableView.rowHeight = 94
        
    }
}

extension MovieListController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! ListTableViewCell
        cell.movieName.text = nameList[indexPath.row]
        cell.ratingOfMovie.text = ratingList[indexPath.row]
        cell.releaseDate.text = realesedateList[indexPath.row]
        cell.movieImage.image = imageList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailPageController") as? DetailPageController
        getMovieDetail(movieNum: indexPath.row, list: idList)
        vc?.name = nameList[indexPath.row]
        vc?.poster = imageList[indexPath.row]
        vc?.releaseDate = realesedateList[indexPath.row]
        vc?.runTime = movieRuntime
        vc?.revenue = movieRevenue
        vc?.overview = overviewTextList[indexPath.row]
        vc?.budget = movieBudget
        vc?.runTime = movieRuntime
        getCastDetail(movieNum: indexPath.row, list: idList)
        navigationController?.pushViewController(vc!, animated: true)
    }
    
}

//MARK: - MovieListPage

extension MovieListController {
    
    func performRequest(with urlString: URL) {
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: urlString) { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            if let safeData = data {
                if let moviesList = self.moviesManager.parseMovieList(safeData) {
                    self.didUploadMovieList(moviesList: moviesList)
                }
            }
        }
        task.resume()
    }
    
    func didUploadMovieList(moviesList: MoviesListModel) {
        DispatchQueue.main.async { [self] in
            
            self.nameList = moviesList.nameList
            self.realesedateList = moviesList.releasedateList
            self.ratingList = moviesList.ratingList
            self.posterPathList = moviesList.posterPath
            self.overviewTextList = moviesList.overviewTextList
            self.idList = moviesList.idList
            
            var counter: Int = 0
            
            for counter in 0...19 {
                
                getMovieImages(idNumber: counter)
                
                if let urlPath = URL(string: imageUrlString) {
                    let data = try? Data(contentsOf: urlPath)
                    let image = UIImage(data: data!)!
                    imageList.append(image)
                }
                
                self.listTableView.reloadData()
            }
        }
    }
    
    func getPopularMovies() {
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.themoviedb.org"
        components.path = "/3/movie/popular"
        components.queryItems = [
            URLQueryItem(name: "api_key", value: moviesManager.apiKey)
        ]
        let url = components.url
        performRequest(with: url!)
    }
    
    
    func URLImage(index: Int, List: [String]) {
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "image.tmdb.org"
        components.path = "/t/p/w500\(List[index])"
        
        let imageUrl = components.url!
        imageUrlString = imageUrl.absoluteString
    }
    
    func getMovieImages(idNumber: Int) {
        URLImage(index: idNumber, List: posterPathList)
    }
}

//MARK: - DetailPage

extension MovieListController {
    
    func performDetailRequest(with urlString: URL) {
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: urlString) { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            if let safeData = data {
                if let details = self.moviesManager.parseMovieDetail(safeData) {
                    self.didUploadMovieDetails(details)
                }
            }
        }
        task.resume()
    }
    
    func didUploadMovieDetails(_ details: MovieDetailModel) {
        DispatchQueue.main.async { [self] in
            
            self.movieBudget = details.movieBudget
            self.movieRevenue = details.movieRevenue
            self.movieRuntime = details.movieRuntime
            self.genreList = details.genreList
            print(genreList)
            // how to reload this View?
        }
    }
    
    func getMovieDetail(movieNum: Int, list: [Int]) {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.themoviedb.org"
        components.path = "/3/movie/\(list[movieNum])"
        components.queryItems = [
            URLQueryItem(name: "api_key", value: moviesManager.apiKey)
        ]
        let detailUrl = components.url
        performDetailRequest(with: detailUrl!)
    }
    
    //MARK: - Cast&CastDetailPage
    
    func performCastRequest(with urlString: URL) {
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: urlString) { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            if let safeData = data {
                if let details = self.moviesManager.parseCast(safeData) {
                    self.didUploadCastDetails(details)
                }
            }
        }
        task.resume()
    }
    func getCastDetail(movieNum: Int, list: [Int]) {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.themoviedb.org"
        components.path = "/3/movie/\(list[movieNum])/credits"
        components.queryItems = [
            URLQueryItem(name: "api_key", value: moviesManager.apiKey)
        ]
        let castUrl = components.url
    }
    func didUploadCastDetails(_ castList: CastListModel) {
        DispatchQueue.main.async { [self] in
            
            self.castNameList = castList.castNameList
            self.castProfilePathList = castList.profilepathList
            self.characterNameList = castList.characterList
           
            
            // how to reload this View?
        }
    }
    
    func getCastPhoto(index: Int, castList: [String]) {
        URLImage(index: index, List: castList)
    }
}
