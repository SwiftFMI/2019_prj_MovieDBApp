import UIKit

class MoviesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            self.titleLabel.numberOfLines = 0
        }
    }
    
    @IBOutlet weak var posterImageView: UIImageView! {
        didSet {
            self.posterImageView.contentMode = .scaleAspectFit
        }
    }
}
