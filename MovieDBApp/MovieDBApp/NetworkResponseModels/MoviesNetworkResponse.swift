import Foundation

struct MoviesNetworkResponse: Decodable {
    let page: Int
    let totalResults: Int
    let totalPages: Int
    let results: [MovieNetworkResponse]
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
}
