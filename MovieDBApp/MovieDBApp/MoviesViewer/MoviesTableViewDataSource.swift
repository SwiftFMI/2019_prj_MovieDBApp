import UIKit

class MoviesTableViewDataSource: NSObject {
    private var movies = [Movie]()
    private var page = 1
    private var movieService = MovieService()
    
    weak private var moviesTableView: UITableView?
    
    init(_ searchPhrase: String? = nil) {
        super.init()
        self.loadDataSource(searchPhrase)
    }
    
    func movieAt(indexPath: IndexPath) -> Movie? {
        guard indexPath.row >= 0 && indexPath.row < movies.count else { return nil }
        return self.movies[indexPath.row]
    }
    
    func loadDataSource(_ searchPhrase: String? = nil) {
        let moviesCompletion: ((Result<[Movie], Error>) -> Void) = { [weak self] (result) in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let newMovies):
                self?.movies.append(contentsOf: newMovies)
                self?.page += 1
                
                for movie in self?.movies ?? [] {
                    movie.posters { (result) in
                        switch result {
                        case .success(let posters):
                            if let poster = posters.first {
                                UIImage.image(fromURL: poster.url) {  [weak self] (result) in
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
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                }
                
                DispatchQueue.main.async {
                    self?.moviesTableView?.reloadData()
                }
            } 
        }
        
        if let searchPhrase = searchPhrase {
            self.movieService.search(forMovie: searchPhrase, page: self.page, completionHandler: moviesCompletion)
        } else {
            self.movieService.getMovies(page: self.page, completionHandler: moviesCompletion)
        }
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
        cell.posterImageView.contentMode = .scaleAspectFit
        cell.titleLabel.numberOfLines = 0
        
        return cell
    }
}

extension MoviesTableViewDataSource: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {}
}

