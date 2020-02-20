//
//  MovieService.swift
//  MovieDBApp
//
//  Created by User on 10.02.20.
//  Copyright © 2020 TwoGirlsOneApp. All rights reserved.
//

import Foundation

class MovieService { // for refactoring, again; alll of the methods are identical
    
    func getMoviePoster(id: Int, completionHandler: @escaping ((String) -> Void)) {
        var urlComponents = URLComponents(url: Constants.MOVIE_URL)!
        
        let apiKeyQueryItem = URLQueryItem(name: "api_key", value: Constants.API_KEY)
        
        
        urlComponents.queryItems = [apiKeyQueryItem]
        guard let url = urlComponents.url?.appendingPathComponent("\(id)/images") else { completionHandler("fuck.jpg"); return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let response = response as? HTTPURLResponse {
                switch response.statusCode {
                case 200: // Success
                    if let data = data {
                        do {
                            let movieResponseBody = try JSONDecoder().decode(MovieImagesNetworkResponse.self, from: data)
                            completionHandler(movieResponseBody.posters.first?.filePath ?? "fuck.jpg")
                        } catch {
                            print("Error while decoding movies: \(error.localizedDescription)")
                        }
                    }
                    print(response)
                default:
                    print("Error while downloading posters: unexpected response code: \(response.statusCode)")
                }
            }
        }.resume()
    }
    
    func getMovies(page: Int, completionHandler: @escaping (([Movie]) -> Void)) {
        var urlComponents = URLComponents(url: Constants.DISCOVER_URL)!
        
        let apiKeyQueryItem = URLQueryItem(name: "api_key", value: Constants.API_KEY)
        let languageQueryItem = URLQueryItem(name: "language", value: "en-US")
        let sortByQueryItem = URLQueryItem(name: "sort_by", value: "popularity.desc")
        let includeAdultQueryItem = URLQueryItem(name: "include_adult", value: "false")
        let includeVideoQueryItem = URLQueryItem(name: "include_video", value: "false")
        let pageQueryItem = URLQueryItem(name: "page", value: "\(page)")
        
        urlComponents.queryItems = [apiKeyQueryItem, languageQueryItem, sortByQueryItem, includeAdultQueryItem, includeVideoQueryItem, pageQueryItem]
        
        URLSession.shared.dataTask(with: urlComponents.url!) { data,response,error in
            if let error = error {
                print("Error while downloading movies: \(error.localizedDescription)")
                completionHandler([])
            }
            
            if let response = response as? HTTPURLResponse {
                switch response.statusCode {
                case 200: // Success
                    if let data = data {
                        do {
                            let responseBody = try JSONDecoder().decode(MoviesNetworkResponse.self, from: data)
                            let movies = responseBody.results.map { Movie(fromNetworkResponse: $0) }
                            completionHandler(movies)
                        } catch {
                            print("Error while decoding movies: \(error.localizedDescription)")
                        }
                    }
                // FIXME: Handle these better
                case 401:
                    print("Error while downloading movies: 401 unaithorised")
                case 404:
                    print("Error while downloading movies: 404 Not found")
                case 422:
                    print("asd")
                    print(response)
                default:
                    print("Error while downloading movies: unexpected response code: \(response.statusCode)")
                }
            } else {
                print("Unexpected response type")
                completionHandler([])
            }
            
        }.resume()
    }
    
    func search(forMovie searchedMovie: String, page: Int, completionHandler: @escaping (([Movie]) -> Void)) {
        var urlComponents = URLComponents(url: Constants.SEARCH_URL)!
        
        let apiKeyQueryItem = URLQueryItem(name: "api_key", value: Constants.API_KEY)
        let languageQueryItem = URLQueryItem(name: "language", value: "en-US")
        let newMovieQueryItem = URLQueryItem(name: "query", value: searchedMovie)
        let pageQueryItem = URLQueryItem(name: "page", value: "\(page)")
        let includeAdultQueryItem = URLQueryItem(name: "include_adult", value: "false")
        
        urlComponents.queryItems = [apiKeyQueryItem, languageQueryItem, newMovieQueryItem, pageQueryItem, includeAdultQueryItem]
        
        URLSession.shared.dataTask(with: urlComponents.url!) { data,response,error in
            if let error = error {
                print("Error while downloading movies: \(error.localizedDescription)")
                completionHandler([])
            }
            
            if let response = response as? HTTPURLResponse {
                switch response.statusCode {
                case 200: // Success
                    if let data = data {
                        do {
                            let responseBody = try JSONDecoder().decode(MoviesNetworkResponse.self, from: data)
                            let movies = responseBody.results.map { Movie(fromNetworkResponse: $0) }
                            completionHandler(movies)
                        } catch {
                            print("Error while decoding movies: \(error.localizedDescription)")
                        }
                    }
                // FIXME: Handle these better
                case 401: // Unauthorised
                    print("Error while downloading movies: 401 Unaithorised")
                case 404: // Not Found
                    print("Error while downloading movies: 404 Not Found")
                default:
                    print("Error while downloading movies: unexpected response code: \(response.statusCode)")
                }
            } else {
                print("Unexpected response type")
                completionHandler([])
            }
            
        }.resume()
    }
}

