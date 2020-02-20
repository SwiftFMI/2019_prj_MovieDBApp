import UIKit

class MoviesViewController: UIViewController {
    private var moviesDataSource: MoviesTableViewDataSource!
    
    @IBOutlet weak var moviesTableView: UITableView!
    
    var isInSearchMode = false
    
    override func viewDidLoad() {
        
        //        self.moviesTableView.prefetchDataSource = self.moviesDataSource
        self.moviesTableView.delegate = self
        
        if isInSearchMode {
            self.moviesDataSource = MoviesTableViewDataSource(text: self.title)
        } else {
            self.moviesDataSource = MoviesTableViewDataSource()
            self.configAsDefault()
        }
        
        self.moviesTableView.dataSource = self.moviesDataSource
    }
}

extension MoviesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailsViewController = UIStoryboard(name: "Details", bundle: nil).instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController else { return }
        
        detailsViewController.movie = self.moviesDataSource.movieAt(indexPath: indexPath)
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 530
    }
}

extension MoviesViewController: UISearchControllerDelegate {
    func willPresentSearchController(_ searchController: UISearchController) {

    }
}

//extension MoviesViewController: UISearchResultsUpdating {
////    func updateSearchResults(for searchController: UISearchController) {
////        guard let text = searchController.searchBar.text, !text.isEmpty else { return }
//////        self.moviesDataSource.searchMovies(text: text)
//    }
//}

extension MoviesViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {        
        guard let detailsViewController = UIStoryboard(name: "Initial", bundle: nil).instantiateViewController(withIdentifier: "MoviesViewControllerID") as? MoviesViewController else { return }
        
        detailsViewController.title = searchBar.text!
        detailsViewController.isInSearchMode = true
        self.navigationController?.pushViewController(detailsViewController, animated: true)
    }
}

extension MoviesViewController {
    func configAsDefault() {
        self.title = "Popular movies"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        let searchController = UISearchController.init(searchResultsController: nil)
        searchController.searchBar.placeholder = "Search movies"
        searchController.searchBar.delegate = self
        self.navigationItem.searchController = searchController
        definesPresentationContext = true
    }
}
