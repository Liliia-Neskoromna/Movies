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
// MARK: - Extension for FilmViewController

var spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
var loadingView: UIView = UIView()
var view = FilmViewController.init().view.self

extension FilmViewController {
    
    func showActivityIndicator() {
        DispatchQueue.main.async {
            loadingView = UIView()
            loadingView.frame = CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0)
            loadingView.center = self.view?.center as! CGPoint
            loadingView.backgroundColor = UIColor.gray
//            (named: "#444444")
            loadingView.alpha = 0.7
            loadingView.clipsToBounds = true
            loadingView.layer.cornerRadius = 10
            
            spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
            spinner.frame = CGRect(x: 0.0, y: 0.0, width: 80.0, height: 80.0)
            spinner.center = CGPoint(x:loadingView.bounds.size.width / 2, y:loadingView.bounds.size.height / 2)
            
            loadingView.addSubview(spinner)
            self.view?.addSubview(loadingView)
            spinner.startAnimating()
        }
    }
    
    func hideActivityIndicator() {
        DispatchQueue.main.async {
            spinner.stopAnimating()
            loadingView.removeFromSuperview()
        }
    }
}

extension FilmViewController {
    func didUpdateFilmsList(films: [FilmModel]) {
        self.films = films
    }
}
