import UIKit

class MoviesTableViewDataSource: NSObject {
    
    private var movies = [Movie]() //{
//        didSet {
//            DispatchQueue.main.async {
//                self.moviesTableView?.reloadData()
//            }
//        }
//    }
    // remove those temp vars
    var isInSearch = false
    var text = ""
    
    private var searchedMovies = [Movie]()
    
    private var page = 1
    private var movieService = MovieService()
    
    weak private var moviesTableView: UITableView?
    
    init(text: String? = nil) {
        super.init()
        if let search = text {
            self.isInSearch = true
            self.searchMovies(text: search)
        } else {
            self.loadMovies(forPage: self.page)
        }
        
    }
    
    func movieAt(indexPath: IndexPath) -> Movie? {
        if isInSearch {
            guard indexPath.row >= 0 && indexPath.row < searchedMovies.count else { return nil }
            return self.searchedMovies[indexPath.row]
        }
        guard indexPath.row >= 0 && indexPath.row < movies.count else { return nil }
        return self.movies[indexPath.row]
    }
    
    func searchMovies(text: String) { // just refactor this hell
        isInSearch = true
        let completion: (([Movie]) -> Void) = { [weak self] (newMovies) in
            self?.searchedMovies = newMovies
            
            for movie in self?.searchedMovies ?? [] {
                movie.posterFilePath { (result) in
                    switch result {
                    case .success(let posterPath):
                        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)") else { return }
                        
                        UIImage.image(fromURL: url) { (result) in
                            switch result {
                            case .success(let image):
                                movie.poster = image
                                DispatchQueue.main.async {
                                    self?.moviesTableView?.reloadData()
                                }
                            case .failure(let error):
                                print(error.localizedDescription)
                            }
                        } 
                    }
                }
            }
            
            DispatchQueue.main.async {
                self?.moviesTableView?.reloadData()
            }
        }
        
        self.movieService.search(forMovie: text, page: 1, completionHandler: completion)
    }
    
    func loadMovies(forPage page: Int) { // just refactor this
        let completion: (([Movie]) -> Void) = { [weak self] (newMovies) in
            self?.movies.append(contentsOf: newMovies)
            self?.page += 1
            
            for movie in self?.movies ?? [] {
                movie.posterFilePath { (result) in
                    switch result {
                    case .success(let posterPath):
                        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)") else { return }
                        
                        UIImage.image(fromURL: url) { (result) in
                            switch result {
                            case .success(let image):
                                movie.poster = image
                                DispatchQueue.main.async {
                                    self?.moviesTableView?.reloadData()
                                }
                            case .failure(let error):
                                print(error.localizedDescription)
                            }
                        } 
                    }
                }
            }
            
            DispatchQueue.main.async {
                self?.moviesTableView?.reloadData()
            }
        }
        
        self.movieService.getMovies(page: self.page, completionHandler: completion) 
    }
}

extension MoviesTableViewDataSource: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.moviesTableView = tableView
        return self.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MoviesTableViewCellIdentifier", for: indexPath) as! MoviesTableViewCell
        let model = self.movieAt(indexPath: indexPath)
        
        cell.titleLabel.text = model?.originalTitle
        
        cell.posterImageView.image = model?.poster
        cell.posterImageView.contentMode = .scaleAspectFit  // maybe view model
        cell.titleLabel.numberOfLines = 0
        
        return cell
    }
}

extension MoviesTableViewDataSource: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {}
}

