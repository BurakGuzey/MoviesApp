//
//  ViewController.swift
//  MoviesApp
//
//  Created by Burak Güzey on 1.07.2022.
//

import UIKit

class MovieListController: UIViewController, UITableViewDelegate {
    
    
    var moviesManager = MoviesManager()
    var nameList = [String]()
    var realesedateList = [String]()
    var ratingList = [String]()
    var posterPathList = [String]()
    var realImage = UIImage()
    var urlStringReal = String()
    
    @IBOutlet weak var listTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listTableView.dataSource = self
        listTableView.delegate = self
        
        
        listTableView.register(UINib(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        
        getPopular()
        
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
        cell.movieImage.image = realImage
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        navigationController?.pushViewController(DetailPageController(), animated: true)
    }
    
}

extension MovieListController {
    
    func performRequest(with urlString: URL) {
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: urlString) { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            if let safeData = data {
                if let moviesList = self.moviesManager.parseJSON(safeData) {
                    self.didUploadMovieList(moviesList: moviesList)
                }
            }
        }
        task.resume()
    }
    
    func didUploadMovieList(moviesList: MoviesModel2) {
        DispatchQueue.main.async { [self] in
            
            self.posterPathList = moviesList.posterPath
            self.nameList = moviesList.nameList
            self.realesedateList = moviesList.releasedateList
            self.ratingList = moviesList.ratingList
           
            getImage()
          

            if let urlPath = URL(string: urlStringReal) {
            let data = try? Data(contentsOf: urlPath) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                realImage = UIImage(data: data!)!
            }
            
            self.listTableView.reloadData()
            
        }
    }
    
    func getPopular() {
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.themoviedb.org"
        components.path = "/3/movie/popular"
        components.queryItems = [
            URLQueryItem(name: "api_key", value: moviesManager.apiKey),
        ]
        let urlString = components.url
        performRequest(with: urlString!)
    }
    
    
    func getImage() {
        
        let urlString = "https://image.tmdb.org/t/p/w500/\(posterPathList[0])"
        urlStringReal = urlString
    }
}


