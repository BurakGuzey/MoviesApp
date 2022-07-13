//
//  File.swift
//  MoviesApp
//
//  Created by Burak Güzey on 7.07.2022.
//

import Foundation

struct MoviesManager {
    let baseURL = "https://api.themoviedb.org/3"
    let apiKey = "16e807f61c3e7c6382feff585c3859ad"
    let pageNum: Int
    func getPopularMovies() {
        let urlString = "\(baseURL)/movie/popular?apikey=\(apiKey)&page=\(pageNum)"
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
                    self.parseJSON(safeData)
                }
            }
            task.resume()
        }
    }

    func parseJSON(_ moviesData: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(MoviesData.self, from: moviesData)
            let id = decodedData.result[0].id
            let name = decodedData.result[0].title
            let releaseDate = decodedData.result[0].release_date
            let rating = decodedData.result[0].vote_average
            
            let movies = MoviesModel(movieId: id, movieName: name, movieReleaseDate: releaseDate, ratingOfMovie: rating)
            
        } catch {
            print(error)
        }
    }
}
