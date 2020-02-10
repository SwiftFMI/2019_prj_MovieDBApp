//
//  Movie.swift
//  MovieDBApp
//
//  Created by User on 7.02.20.
//  Copyright © 2020 TwoGirlsOneApp. All rights reserved.
//

import Foundation
import UIKit

struct Movie: Decodable {
    let popularity: Double?
    let voteCount: Int?
    let video: Bool?
    let posterSmall: UIImage? = nil
    let posterLarge: UIImage? = nil
    let id: Int?
    let isAdultRated: Bool?
    let originalLanguage: String?
    let originalTitle: String?
    let genres: [String]? = nil
    let title: String?
    let voteAverage: Double?
    let overview: String?
    let releaseDate: Date? = nil
    
    enum CodingKeys: String, CodingKey {
        case popularity
        case voteCount = "vote_count"
        case video
        case id
        case isAdultRated = "adult"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case title
        case voteAverage = "vote_average"
        case overview
        case releaseDate = "release_date"
    }
}
