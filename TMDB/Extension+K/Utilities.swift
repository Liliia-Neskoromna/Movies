//
//  Utilities.swift
//  TMDB
//
//  Created by Lilia on 8/20/20.
//  Copyright © 2020 Liliia. All rights reserved.
//

import Foundation

class Utilities {
    
    static let sharedUtilities = Utilities()
    
    func getParams(page: Int) -> [String: String] {
        return [
            "api_key": "76984f3d864f02cb288e53d24f6e7d6b",
            "language": "ru-Ru",
            "page": "\(page)"
        ]
    }
}
