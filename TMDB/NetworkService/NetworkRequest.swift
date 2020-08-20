//
//  NetworkService.swift
//  TMDB
//
//  Created by Lilia on 8/19/20.
//  Copyright © 2020 Liliia. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

enum CurrentSegmentType: String {
    case popular, upcoming, topRated
    
    var urlString: String {
        switch self {
        case .popular:
            return "https://api.themoviedb.org/3/movie/popular?api_key=76984f3d864f02cb288e53d24f6e7d6b&language=ru-Ru&page=1"
        case .topRated:
            return "https://api.themoviedb.org/3/movie/top_rated?api_key=76984f3d864f02cb288e53d24f6e7d6b&language=ru-Ru&page=1"
        default:
            return "https://api.themoviedb.org/3/movie/upcoming?api_key=76984f3d864f02cb288e53d24f6e7d6b&language=ru-Ru&page=1"
        }
    }
}

class NetworkRequest {
    
    static let shared = NetworkRequest()
    
    func loadData(completion: @escaping ([FilmModel]) -> Void) {
        
        var filmArray = [FilmModel]()
        
        let currentSegmentType: CurrentSegmentType = .upcoming
        
        AF.request(currentSegmentType.urlString, method: .get).responseJSON { (response) in
            
            switch response.result {
            case .success:
                
                guard let json = try? JSON(response.result.get()) else {
                    fatalError("Cannot get json")
                }
                
                let results = json["results"].arrayValue
                
                for result in results {
                    
                    let image = result["poster_path"].stringValue
                    let title = result["title"].stringValue
                    let overview = result["overview"].stringValue
                    
                    let film = FilmModel(title: title, overview: overview, posterPath: image)
                    
                    filmArray.append(film)
                    completion(filmArray)
                    
                    print("Title - \(title)")
                    print("Image - \(image)")
                    print("Overview - \(overview)")
                    
                }
                
            case let .failure(error):
                print(error)
                completion([])
            }
        }
    }
}
