//
//  FilmsManager.swift
//  TMDB
//
//  Created by Lilia on 8/20/20.
//  Copyright © 2020 Liliia. All rights reserved.
//

import Foundation

protocol FilmsManagerDelegate {
    func didUpdateFilmsList(films: [FilmModel])
    func showActivityIndicator()
    func hideActivityIndicator()
}

class FilmsManager {
    var delegate: FilmsManagerDelegate?
    
    private var filmList = [FilmModel]() {
        didSet {
            delegate?.didUpdateFilmsList(films: filmList)
        }
    }
    
    private var popular = [FilmModel]()
    private var upcoming = [FilmModel]()
    private var topRated = [FilmModel]()
    private let network = NetworkRequest.shared
    
    func loadSegmentData(index: Int) -> Void {
        if index == 0 {
            if popular.count == 0 {
                self.delegate?.showActivityIndicator()
                network.loadData(.popular, completion: { [weak self] data in
                    self?.popular = data
                    self?.filmList = data
                    self?.delegate?.hideActivityIndicator()
                })
            } else {
                filmList = popular
            }
        } else if index == 1 {
            if upcoming.count == 0 {
                self.delegate?.showActivityIndicator()
                network.loadData(.upcoming, completion: { [weak self] data in
                    self?.filmList = data
                    self?.upcoming = data
                    self?.delegate?.hideActivityIndicator()
                })
            } else {
                filmList = upcoming
            }
        } else if index == 2 {
            if topRated.count == 0 {
                self.delegate?.showActivityIndicator()
                network.loadData(.topRated, completion: { [weak self] data in
                    self?.filmList = data
                    self?.topRated = data
                    self?.delegate?.hideActivityIndicator()
                })
            } else {
                filmList = topRated
            }
        }
    }
}
