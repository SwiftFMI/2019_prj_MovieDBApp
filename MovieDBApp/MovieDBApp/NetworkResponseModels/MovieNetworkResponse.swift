import Foundation
import UIKit

struct MovieNetworkResponse: Decodable {
    let posterFilePath: String?
    let isAdultRated: Bool // remove?
    let overview: String
    let releaseDate: String
    let id: Int
    let originalTitle: String
    let title: String
    
    enum CodingKeys: String, CodingKey {
        case posterFilePath = "poster_path"
        case isAdultRated = "adult"
        case overview
        case releaseDate = "release_date"
        case id
        case originalTitle = "original_title"
        case title
    }
}
