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

class NetworkRequest {
    
    static let shared = NetworkRequest()
    private let utilites = Utilities.sharedUtilities
    
    func loadData(_ segment: K.CurrentCategory, completion: @escaping ([FilmModel]) -> Void) {
        
        var filmArray = [FilmModel]()
        AF.request(K.Urls.baseUrl + segment.urlString, method: .get, parameters: utilites.getParams(page: K.nextPage)).responseJSON { (response) in
            
            switch response.result {
            case .success:
                
                guard let json = try? JSON(response.result.get()) else {
                    fatalError("Cannot get json")
                }
                
                let results = json["results"].arrayValue
                
                for result in results {
                    
                    let id = result["id"].intValue
                    let image = result["backdrop_path"].stringValue
                    let fullImage = "https://image.tmdb.org/t/p/w500" + image
                    let title = result["title"].stringValue
                    let overview = result["overview"].stringValue
                    
                    let film = FilmModel(id: id, title: title, overview: overview, posterPath: fullImage)
                    
                    filmArray.append(film)
                    completion(filmArray)
                }
                
            case let .failure(error):
                print(error)
                completion([])
            }
        }
    }
    
    
    func loadDetailsData(id: Int, completion: @escaping ([FilmDetailsModel]) -> Void) {
        
        var filmDetailsArray = [FilmDetailsModel]()
        
        AF.request("\(K.Urls.baseUrl)/\(id)", method: .get, parameters: utilites.getParams(page: K.nextPage)).responseJSON { (response) in
            
            switch response.result {
            case .success:
                
                guard let json = try? JSON(response.result.get()) else {
                    fatalError("Cannot get json")
                }
                
                let image = json["backdrop_path"].stringValue
                let backdropPath = "https://image.tmdb.org/t/p/w500" + image
                
                let genres = json["genres"][0]["name"].stringValue
                let title = json["title"].stringValue
                let overview = json["overview"].stringValue
                let popularity = json["popularity"].floatValue
                let releaseDate = json["release_date"].stringValue
                
                let filmDetails = FilmDetailsModel(backdropPath: backdropPath,
                                                   genres: genres,
                                                   title: title,
                                                   overview: overview,
                                                   popularity: popularity,
                                                   releaseDate: releaseDate)
                
                filmDetailsArray.append(filmDetails)
                completion(filmDetailsArray)
                
            case let .failure(error):
                print(error)
                completion([])
            }
        }
    }
}

