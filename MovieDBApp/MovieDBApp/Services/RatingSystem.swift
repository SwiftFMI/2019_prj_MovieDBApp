//
//  RatingSystem.swift
//  MovieDBApp
//
//  Created by User on 16.02.20.
//  Copyright © 2020 TwoGirlsOneApp. All rights reserved.
//

import Foundation
import Firebase

class RatingSystem {
    
    static func rate(movie: Movie, withRating rating: Int) {
        let ref = Database.database().reference()
        guard let key = ref.child("movie_ratings").childByAutoId().key else { return }
        
        let post = ["name" : movie.title,
                    "rating" : rating] as [String : Any]
        
        let childUpdates = ["/ratings/\(key)" : post,
                            "/movie-ratings/\(movie.title)/\(key)/" : post]
        
        ref.updateChildValues(childUpdates)
    }
    
    static func getRating(forMovie movie: Movie) -> Double {
        return 2.5
    }
}
