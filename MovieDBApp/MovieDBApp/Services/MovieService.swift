//
//  MovieService.swift
//  MovieDBApp
//
//  Created by User on 10.02.20.
//  Copyright © 2020 TwoGirlsOneApp. All rights reserved.
//

import Foundation

class MovieService {
    
    static func getMoviePoster(id: Int, completionHandler: @escaping ((Result<[Poster], Error>) -> Void)) {
        var urlComponents = URLComponents(url: Constants.MOVIE_URL)!
        
        let apiKeyQueryItem = URLQueryItem(name: "api_key", value: Constants.API_KEY)
        
        urlComponents.queryItems = [apiKeyQueryItem]
        let url = urlComponents.url!.appendingPathComponent("\(id)/images")
        
        URLSession.shared.dataTask(with: url) { (result) in
            switch result {
            case .success(let data):
                do {
                    let responseBody = try JSONDecoder().decode(MovieImagesNetworkResponse.self, from: data)
                    let posters = responseBody.posters.map { Poster(fromNetworkResponse: $0) }
                    completionHandler(.success(posters))
                } catch {
                    completionHandler(.failure(error))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }   
        }.resume()
    }
    
    func getMovies(page: Int, completionHandler: @escaping ((Result<[Movie], Error>) -> Void)) {
        var urlComponents = URLComponents(url: Constants.DISCOVER_URL)!
        
        let apiKeyQueryItem = URLQueryItem(name: "api_key", value: Constants.API_KEY)
        let languageQueryItem = URLQueryItem(name: "language", value: "en-US")
        let sortByQueryItem = URLQueryItem(name: "sort_by", value: "popularity.desc")
        let includeAdultQueryItem = URLQueryItem(name: "include_adult", value: "false")
        let includeVideoQueryItem = URLQueryItem(name: "include_video", value: "false")
        let pageQueryItem = URLQueryItem(name: "page", value: "\(page)")
        
        urlComponents.queryItems = [apiKeyQueryItem, languageQueryItem, sortByQueryItem, includeAdultQueryItem, includeVideoQueryItem, pageQueryItem]
        
        URLSession.shared.dataTask(with: urlComponents.url!) { (result) in
            switch result {
            case .success(let data):
                do {
                    let responseBody = try JSONDecoder().decode(MoviesNetworkResponse.self, from: data)
                    let movies = responseBody.results.map { Movie(fromNetworkResponse: $0) }
                    completionHandler(.success(movies))
                } catch {
                    completionHandler(.failure(error))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }   
        }.resume()
    }
    
    func search(forMovie searchedMovie: String, page: Int, completionHandler: @escaping ((Result<[Movie], Error>) -> Void)) {
        var urlComponents = URLComponents(url: Constants.SEARCH_URL)!
        
        let apiKeyQueryItem = URLQueryItem(name: "api_key", value: Constants.API_KEY)
        let languageQueryItem = URLQueryItem(name: "language", value: "en-US")
        let newMovieQueryItem = URLQueryItem(name: "query", value: searchedMovie)
        let pageQueryItem = URLQueryItem(name: "page", value: "\(page)")
        let includeAdultQueryItem = URLQueryItem(name: "include_adult", value: "false")
        
        urlComponents.queryItems = [apiKeyQueryItem, languageQueryItem, newMovieQueryItem, pageQueryItem, includeAdultQueryItem]
        
        URLSession.shared.dataTask(with: urlComponents.url!) { (result) in
            switch result {
            case .success(let data):
                do {
                    let responseBody = try JSONDecoder().decode(MoviesNetworkResponse.self, from: data)
                    let movies = responseBody.results.map { Movie(fromNetworkResponse: $0) }
                    completionHandler(.success(movies))
                } catch {
                    completionHandler(.failure(error))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }   
        }.resume()
    }
}
