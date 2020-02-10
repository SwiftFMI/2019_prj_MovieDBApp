//
//  InitialTableViewController.swift
//  MovieDBApp
//
//  Created by User on 7.02.20.
//  Copyright © 2020 TwoGirlsOneApp. All rights reserved.
//

import UIKit

class InitialTableViewController: UITableViewController {

    private var movies: [Movie] = []
    private var pageReached: Int = 1
    /// Fetches the movies from TheMovieDB API
    private let movieService = MovieService()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        movieService.getMovies(page: pageReached) { [weak self] (newMovies) in
            self?.movies += newMovies
            self?.pageReached += 1
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movies.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath)

        return cell
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
