//
//  File.swift
//  MoviesApp
//
//  Created by Burak Güzey on 7.07.2022.
//

import Foundation

protocol MoviesManagerDelegate {
    func didUploadMovieList(movies: MoviesModel)
}

struct MoviesManager {
    let baseURL = "https://api.themoviedb.org/3"
    let apiKey = "16e807f61c3e7c6382feff585c3859ad"
    let pageNum: Int
    let lang: String
    
    var delegate: MoviesManagerDelegate?
    
    func getPopularMovies() {
        let urlString = "\(baseURL)/movie/popular?api_key=\(apiKey)&page=\(pageNum)&language=\(lang)"
        performRequest(with: urlString)
    }
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    if let movies = self.parseJSON(safeData) {
                        self.delegate?.didUploadMovieList(movies: movies)
                    } 
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ moviesData: Data) -> MoviesModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(MoviesData.self, from: moviesData)
            let id = decodedData.results[0].id
            let name = decodedData.results[0].title
            let releaseDate = decodedData.results[0].release_date
            let rating = decodedData.results[0].vote_average
            let poster = decodedData.results[0].poster_path
            let movies = MoviesModel(movieId: id,
                                     movieName: name,
                                     movieReleaseDate: releaseDate,
                                     ratingOfMovie: rating,
                                     posterPhoto: poster)
    
            return movies
            
        } catch {
            print(error)
            return nil
        }
    }
}
