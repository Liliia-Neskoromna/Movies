//
//  Extension.swift
//  TMDB
//
//  Created by Lilia on 8/19/20.
//  Copyright © 2020 Liliia. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import AlamofireImage

// MARK: - Extension for Image

var imageCache = NSCache<NSString, UIImage>()
extension UIImageView {
    
    public func imageFromServerURL(_ urlString: String) {
        self.image = nil
        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            self.image = cachedImage
            return
        }
        
        AF.request(urlString)
            .responseImage {response in
                if let downloadedImage = try? response.result.get() {
                    imageCache.setObject(downloadedImage, forKey: urlString  as NSString)
                    self.image = downloadedImage
                }
        }
    }
}
