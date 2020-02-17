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
    
    func rate(movie: Movie, withRating rating: Int) {
        var ref: DatabaseReference!

        ref = Database.database().reference()
        
        // MARK: Save data
    }
}
