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

    var movie: Movie!
    var ratingSystem = RatingSystem()
    
    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieReleaseDateLabel: UILabel!
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    @IBOutlet weak var starRatingView: HCSStarRatingView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieTitleLabel.text = movie.title
        moviePosterImageView.image = movie.posterLarge
        movieDescriptionLabel.text = movie.overview
    }
    
    deinit {
        let rating = Int(starRatingView.value)
        if rating != 0 {
            ratingSystem.rate(movie: movie, withRating: rating)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
