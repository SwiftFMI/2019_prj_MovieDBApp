//
//  Movie.swift
//  MovieDBApp
//
//  Created by User on 7.02.20.
//  Copyright © 2020 TwoGirlsOneApp. All rights reserved.
//

import Foundation

struct Movie {
    let popularity: Double?
    let voteCount: Int?
    let video: Bool?
    let posterSmall: UIImage?
    let posterLarge: UIImage?
    let id: Int?
    let isAdultRated: Bool?
    let originalLanguage: String?
    let originalTitle: String?
    let genres: [String]?
    let title: String?
    let voteAverage: Double?
    let overview: String?
    let releaseDate: Date?
}
