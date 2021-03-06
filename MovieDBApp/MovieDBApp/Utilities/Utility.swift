//
//  Utility.swift
//  MovieDBApp
//
//  Created by User on 10.02.20.
//  Copyright © 2020 TwoGirlsOneApp. All rights reserved.
//

import UIKit

extension URL {
    func appendingPathComponent(_ url: URL) -> URL {
        return self.appendingPathComponent(url.absoluteString)
    }
}

extension URLComponents {
    init?(url: URL) {
        self.init(string: url.absoluteString)
    }
}

extension UIImage {
    static func image(fromURL url: URL?, completion: @escaping ((Result<UIImage, ImageError>) -> Void)) {
        guard let url = url, let data = try? Data(contentsOf: url) else { 
            completion(.failure(.cannotReadFromURL))
            return
        }
        guard let image = UIImage(data: data) else { 
            completion(.failure(.cannotCreateImageFromData))
            return
        }
        
        completion(.success(image))
    }
    
    enum ImageError: Error {
        case cannotReadFromURL
        case cannotCreateImageFromData
    }
}

extension URLSession {
    func dataTask(with url: URL, completionHandler: @escaping ((Result<Data, Error>) -> Void)) -> URLSessionDataTask {
        return dataTask(with: url) { (data, response, error) in
            if let error = error {
                completionHandler(.failure(error))
            } else {
                completionHandler(.success(data ?? Data()))
            }
        }
    }
}
