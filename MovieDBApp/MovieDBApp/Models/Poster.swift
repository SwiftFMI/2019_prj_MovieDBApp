//
//  Poster.swift
//  MovieDBApp
//
//  Created by Ognyanka Boneva on 20.02.20.
//  Copyright © 2020 TwoGirlsOneApp. All rights reserved.
//

import Foundation

class Poster {
    let url: URL
    
    init(fromNetworkResponse response: PosterNetworkResponse) {
        self.url = Constants.POSTER_BASE_URL.appendingPathComponent(response.filePath)
    }
    
    init(fromFilePath path: String) {
        self.url = Constants.POSTER_BASE_URL.appendingPathComponent(path)
    }
}
