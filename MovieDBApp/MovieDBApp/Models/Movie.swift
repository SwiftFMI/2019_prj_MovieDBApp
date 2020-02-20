//
//  Movie.swift
//  MovieDBApp
//
//  Created by Ognyanka Boneva on 18.02.20.
//  Copyright © 2020 TwoGirlsOneApp. All rights reserved.
//

import UIKit


class Movie { // could add images in details controller
    let id: Int
    private let posterFilePath: String?
    let originalTitle: String
    let overview: String
    let title: String
    let releaseDate: String
//    let images: // could add images in details controller
    
    var poster: UIImage? // should not be here
    
    init(fromNetworkResponse response: MovieNetworkResponse) {
        self.id = response.id
        self.posterFilePath = response.posterFilePath
        self.originalTitle = response.originalTitle
        self.overview = response.overview
        self.title = response.title
        self.releaseDate = response.releaseDate
    }
    
    func posterFilePath(completion: @escaping (Result<String, MoviePosterError>) -> Void) { // remove from here
        if let poster = self.posterFilePath {
            completion(.success(poster))
        } else {
            MovieService().getMoviePoster(id: self.id) { completion(.success($0)) }
        }
    }
    
    enum MoviePosterError: Error {}
}
