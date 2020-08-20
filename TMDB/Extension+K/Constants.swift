//
//  FilmsManager.swift
//  TMDB
//
//  Created by Lilia on 8/20/20.
//  Copyright © 2020 Liliia. All rights reserved.
//

struct K {
    
    static let cellIdentifire = "CustomCell"
    static let nibName = "FilmCustomCell"
    
    struct Urls {
        static let baseUrl = "https://api.themoviedb.org/3/movie"
        
//        static let popular = "/popular"
//        static let toprated = "/top_rated"
//        static let upcoming = "/upcoming"
    }
    
    enum CurrentCategory: String {
        case popular, upcoming, topRated
        
        var urlString: String {
            switch self {
            case .popular:
                return "/popular"
            case .topRated:
                return "/top_rated"
            default:
                return "/upcoming"
            }
        }
    }

}
