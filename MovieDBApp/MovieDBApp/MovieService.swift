//
//  MovieService.swift
//  MovieDBApp
//
//  Created by User on 10.02.20.
//  Copyright © 2020 TwoGirlsOneApp. All rights reserved.
//

import Foundation

class MovieService {
    
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
                            let responseBody = try JSONDecoder().decode(ResponseBody.self, from: data)
                            completionHandler(responseBody.results)
                        } catch {
                            print("Error while decoding movies: \(error.localizedDescription)")
                        }
                    }
                // FIXME: Handle these better
                case 401:
                    print("Error while downloading movies: 401 unaithorised")
                case 404:
                    print("Error while downloading movies: 404 Not found")
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
                            let responseBody = try JSONDecoder().decode(ResponseBody.self, from: data)
                            completionHandler(responseBody.results)
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
    
    private struct ResponseBody: Decodable {
        let page: Int
        let totalResults: Int
        let totalPages: Int
        let results: [Movie]
        
        enum CodingKeys: String, CodingKey {
            case page
            case totalResults = "total_results"
            case totalPages = "total_pages"
            case results
        }
    }
}

