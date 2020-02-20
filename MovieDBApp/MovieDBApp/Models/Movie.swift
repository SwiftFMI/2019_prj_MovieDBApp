//
//  Movie.swift
//  MovieDBApp
//
//  Created by Ognyanka Boneva on 18.02.20.
//  Copyright © 2020 TwoGirlsOneApp. All rights reserved.
//

import UIKit


class Movie {
    let id: Int
    private let posterFilePath: String?
    let originalTitle: String
    let overview: String
    let title: String
    let releaseDate: String
    
    var poster: UIImage?
    
    init(fromNetworkResponse response: MovieNetworkResponse) {
        self.id = response.id
        self.posterFilePath = response.posterFilePath
        self.originalTitle = response.originalTitle
        self.overview = response.overview
        self.title = response.title
        self.releaseDate = response.releaseDate
    }
    
    func posters(completion: @escaping (Result<[Poster], Error>) -> Void) {
        if let path = self.posterFilePath {
            completion(.success([Poster(fromFilePath: path)]))
        } else {
            MovieService.getMoviePoster(id: self.id, completionHandler: completion)
        }
    }
}
