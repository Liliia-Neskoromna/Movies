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
}
