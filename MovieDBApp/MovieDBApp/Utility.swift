//
//  Utility.swift
//  MovieDBApp
//
//  Created by User on 10.02.20.
//  Copyright © 2020 TwoGirlsOneApp. All rights reserved.
//

import Foundation

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
