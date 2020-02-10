//
//  MovieService.swift
//  MovieDBApp
//
//  Created by User on 10.02.20.
//  Copyright © 2020 TwoGirlsOneApp. All rights reserved.
//

import Foundation

class MovieService {
    
    func getMovies(page: Int, completionHandler: (([Movie]) -> Void)) {
        var urlComponents = URLComponents(url: Constants.DISCOVER_URL)!
        
        let apiKeyQueryItem = URLQueryItem(name: "api_key", value: Constants.API_KEY)
        let languageQueryItem = URLQueryItem(name: "language", value: "en-US")
        let sortByQueryItem = URLQueryItem(name: "sort_by", value: "popularity.desc")
        let includeAdultQueryItem = URLQueryItem(name: "include_adult", value: "false")
        let includeVideoQueryItem = URLQueryItem(name: "include_video", value: "false")
        let pageQueryItem = URLQueryItem(name: "page", value: "\(page)")
        
        urlComponents.queryItems = [apiKeyQueryItem, languageQueryItem, sortByQueryItem, includeAdultQueryItem, includeVideoQueryItem, pageQueryItem]
        
        URLSession.shared.dataTask(with: urlComponents.url!) { data,response,error in
            if let data = data {
                print(String(data: data, encoding: .utf8))
            }
        }.resume()
    }
}

