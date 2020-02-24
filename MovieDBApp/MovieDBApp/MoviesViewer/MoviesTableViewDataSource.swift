import UIKit

protocol DataSourceChanged: class {
    func dataSourceChanged() -> Void
}

class MoviesTableViewDataSource: NSObject {
    private var movies = [Movie]()
    private var page = 1
    
    private let movieService = MovieService()
    private let searchPhrase: String?
    
    weak var delegate: DataSourceChanged?
    
    init(_ searchPhrase: String? = nil) {
        self.searchPhrase = searchPhrase
        super.init()
        self.loadDataSource(searchPhrase)
    }
    
    func movieAt(indexPath: IndexPath) -> Movie? {
        guard indexPath.row >= 0 && indexPath.row < movies.count else { return nil }
        return self.movies[indexPath.row]
    }
    
    func loadDataSource(_ searchPhrase: String? = nil) {
        let posterCompletion: ((IndexPath) -> ((Result<[Poster], Error>) -> Void)) = { (indexPath) in
            return { [weak self] (result) in
                switch result {
                case .success(let posters):
                    if let poster = posters.first {
                        UIImage.image(fromURL: poster.url) {  [weak self] (result) in
                            switch result {
                            case .success(let image):
                                self?.movieAt(indexPath: indexPath)?.poster = image
                                self?.delegate?.dataSourceChanged()
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
        
        let moviesCompletion: ((Result<[Movie], FetchingError>) -> Void) = { [weak self] (result) in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let newMovies):
                self?.movies.append(contentsOf: newMovies)
                self?.page += 1
                
                for index in 0...(self?.movies.count ?? 0) {
                    let indexPath = IndexPath.init(row: index, section: 0)
                    let movie = self?.movieAt(indexPath: indexPath)
                    movie?.posters(completion: posterCompletion(indexPath))
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
        return self.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MoviesTableViewCellIdentifier", for: indexPath) as! MoviesTableViewCell
        let model = self.movieAt(indexPath: indexPath)
        
        cell.titleLabel.text = model?.originalTitle
        cell.posterImageView.image = model?.poster
        
        return cell
    }
}

extension MoviesTableViewDataSource: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if let row = indexPaths.max()?.row, row > self.movies.count - 5 {
            self.loadDataSource(self.searchPhrase)
            print("Will load page \(self.page)")
        }
    }
}

