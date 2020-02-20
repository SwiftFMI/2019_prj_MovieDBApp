//
//  Constants.swift
//  MovieDBApp
//
//  Created by User on 10.02.20.
//  Copyright © 2020 TwoGirlsOneApp. All rights reserved.
//

import Foundation

final class Constants {
    
    static let BASE_URL = URL(string: "https://api.themoviedb.org/3")!
    private static let DISCOVER_ENDPOINT = URL(string: "/discover/movie")!
    private static let SEARCH_ENDPOINT = URL(string: "/search/movie")!
    private static let MOVIE_ENDPOINT = URL(string: "/movie")!
    
    // MARK: Should this be in Networking?
    static let API_KEY = "256e06322b4e9c0d53b7267faac1b33d"

    static var DISCOVER_URL: URL {
        return BASE_URL.appendingPathComponent(DISCOVER_ENDPOINT)
    }
    
    static var SEARCH_URL: URL {
        return BASE_URL.appendingPathComponent(SEARCH_ENDPOINT)
    }
    
    static var MOVIE_URL: URL {
        return BASE_URL.appendingPathComponent(MOVIE_ENDPOINT)
    }
    
    static var POSTER_BASE_URL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500/")!
    }
}
