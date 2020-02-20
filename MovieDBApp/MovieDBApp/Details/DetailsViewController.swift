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
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var starRatingView: HCSStarRatingView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = movie?.title
        descriptionTextView.text = movie?.overview
        posterImageView.image = movie?.poster
        releaseDateLabel.text?.append(contentsOf: movie?.releaseDate.replacingOccurrences(of: "_", with: ".") ?? "")
        //add rating label
    }
    
    deinit {
        let rating = Int(starRatingView.value)
        if rating != 0 {
            RatingSystem.rate(movie: movie!, withRating: rating)
        }
    }
}
