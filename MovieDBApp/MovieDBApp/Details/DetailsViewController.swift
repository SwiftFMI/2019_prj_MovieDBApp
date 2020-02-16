//
//  DetailsViewController.swift
//  MovieDBApp
//
//  Created by User on 16.02.20.
//  Copyright © 2020 TwoGirlsOneApp. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    var movie: Movie!
    
    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieReleaseDateLabel: UILabel!
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    @IBOutlet weak var starRatingView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieTitleLabel.text = movie.title
        moviePosterImageView.image = movie.posterLarge
        movieDescriptionLabel.text = movie.overview
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
