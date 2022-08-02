//
//  File.swift
//  MoviesApp
//
//  Created by Burak Güzey on 7.07.2022.
//

import Foundation

protocol MoviesManagerDelegate {
    func didUploadMovieList(moviesList: MoviesModel2)
    }

struct MoviesManager {
    
    let apiKey = "16e807f61c3e7c6382feff585c3859ad"
    
    var delegate: MoviesManagerDelegate?

    func getPopular() {
            var components = URLComponents()
                components.scheme = "https"
                components.host = "api.themoviedb.org"
                components.path = "/3/movie/popular"
                components.queryItems = [
                    URLQueryItem(name: "api_key", value: apiKey)
                ]
            let urlString = components.url
            performRequest(with: urlString!)
        }
    
    func performRequest(with urlString: URL) {
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: urlString) { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            if let safeData = data {
                if let moviesList = self.parseJSON(safeData) {
                    self.delegate?.didUploadMovieList(moviesList: moviesList)
                }
            }
        }
        task.resume()
    }
    
    func parseJSON(_ moviesData: Data) -> MoviesModel2? {
        
        let decoder = JSONDecoder()
        
        do {
            var idList = [Int]()
            var nameList = [String]()
            var releaseDateList = [String]()
            var ratingList = [String]()
            var posterPathList = [String]()
            
            for i in 0...19 {
                let decodedData = try decoder.decode(MoviesData.self, from: moviesData)
                let id = decodedData.results[i].id
                let name = decodedData.results[i].title
                let releaseDate = decodedData.results[i].release_date
                let rating = decodedData.results[i].vote_average
                let poster = decodedData.results[i].poster_path
                
                let ratingString = NSString(format: "%.1f", rating)
                
                let movies = MoviesModel(movieId: id,
                                         movieName: name,
                                         movieReleaseDate: releaseDate,
                                         ratingOfMovie: rating,
                                         posterPhoto: poster)
                
                idList.append(id)
                nameList.append(name)
                releaseDateList.append(releaseDate)
                ratingList.append(ratingString as String)
                posterPathList.append(poster)
                
            }
            
            let moviesList = MoviesModel2(idList: idList,
                                          nameList: nameList,
                                          releasedateList: releaseDateList,
                                          ratingList: ratingList,
                                          posterPath: posterPathList)
            
            return moviesList
            
        } catch {
            print(error)
            return nil
        }
    }
}
