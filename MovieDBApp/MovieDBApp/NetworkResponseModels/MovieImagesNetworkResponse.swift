import Foundation

struct MovieImagesNetworkResponse: Decodable {
    let id: Int
    let posters: [PosterNetworkResponse]
}

struct PosterNetworkResponse: Decodable {
    let filePath: String
    
    enum CodingKeys: String, CodingKey {
        case filePath = "file_path"
    }
}
