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

class NetworkRequest {
    
    static let shared = NetworkRequest()
    
    func loadData(_ segment: CurrentCategory, completion: @escaping ([FilmModel]) -> Void) {
        
        var filmArray = [FilmModel]()
        AF.request(K.Urls.baseUrl + segment.urlString, method: .get, parameters: self.getParams()).responseJSON { (response) in
            
            switch response.result {
            case .success:
                
                guard let json = try? JSON(response.result.get()) else {
                    fatalError("Cannot get json")
                }
                
                let results = json["results"].arrayValue
                
                for result in results {
                    
                    let image = result["backdrop_path"].stringValue
                    let fullImage = "https://image.tmdb.org/t/p/w500" + image
                    let title = result["title"].stringValue
                    let overview = result["overview"].stringValue
                    
                    let film = FilmModel(title: title, overview: overview, posterPath: fullImage)
                    
                    filmArray.append(film)
                    completion(filmArray)
                }
                
            case let .failure(error):
                print(error)
                completion([])
            }
        }
    }
    
    func getParams(page: String = "1") -> [String: String] {
        return [
            "api_key": "76984f3d864f02cb288e53d24f6e7d6b",
            "language": "ru-Ru",
            "page": "\(page)"
        ]
    }
}
