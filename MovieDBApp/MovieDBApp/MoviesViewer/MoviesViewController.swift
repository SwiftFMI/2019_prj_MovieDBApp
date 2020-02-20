import UIKit

class MoviesViewController: UIViewController {
    private var moviesDataSource: MoviesTableViewDataSource? = nil
    
    @IBOutlet weak var moviesTableView: UITableView!
    
    override func viewDidLoad() {
        if self.moviesDataSource == nil {
            self.moviesDataSource = MoviesTableViewDataSource()
            self.configAsDefault()
        }
        
        self.moviesDataSource?.delegate = self
        self.moviesTableView.delegate = self
        self.moviesTableView.dataSource = self.moviesDataSource
        self.moviesTableView.prefetchDataSource = self.moviesDataSource
    }
    
    private func addDataSource(_ dataSource: MoviesTableViewDataSource) {
        self.moviesDataSource = dataSource
    }
}

extension MoviesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailsViewController = UIStoryboard(name: "Details", bundle: nil).instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController else { return }
        
        detailsViewController.movie = self.moviesDataSource?.movieAt(indexPath: indexPath)
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 530
    }
}

extension MoviesViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {        
        guard let detailsViewController = UIStoryboard(name: "Initial", bundle: nil).instantiateViewController(withIdentifier: "MoviesViewControllerID") as? MoviesViewController else { return }
        
        detailsViewController.title = "Results."
        detailsViewController.addDataSource(MoviesTableViewDataSource(searchBar.text!))
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

extension MoviesViewController: DataSourceChanged {
    func dataSourceChanged() {
        DispatchQueue.main.async {
            self.moviesTableView.reloadData()
        }
    }
}
