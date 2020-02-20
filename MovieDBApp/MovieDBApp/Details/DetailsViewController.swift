//
//  DetailsViewController.swift
//  MovieDBApp
//
//  Created by User on 16.02.20.
//  Copyright © 2020 TwoGirlsOneApp. All rights reserved.
//

import UIKit
import HCSStarRatingView

class DetailsViewController: UIViewController {

    var movie: Movie?
    var ratingSystem = RatingSystem()
    
    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var movieReleaseDateLabel: UILabel!
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    @IBOutlet weak var starRatingView: HCSStarRatingView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = movie?.title
        movieDescriptionLabel.text = movie?.overview
        moviePosterImageView.image = movie?.poster
        movieReleaseDateLabel.text?.append(contentsOf: movie?.releaseDate.replacingOccurrences(of: "_", with: ".") ?? "")
    }
    
    deinit {
        let rating = Int(starRatingView.value)
        if rating != 0 {
            ratingSystem.rate(movie: movie!, withRating: rating)
        }
    }
}
