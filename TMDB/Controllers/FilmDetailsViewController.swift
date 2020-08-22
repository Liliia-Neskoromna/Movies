//
//  FilmDetailsViewController.swift
//  TMDB
//
//  Created by Lilia on 8/21/20.
//  Copyright © 2020 Liliia. All rights reserved.
//

import UIKit

class FilmDetailsViewController: UIViewController {
    
    @IBOutlet weak var backDropPathImage: UIImageView!
    @IBOutlet weak var originalTitleLabel: UILabel!
    @IBOutlet weak var collectionLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var releaseDataLabel: UILabel!
    @IBOutlet weak var popularityLabel: UILabel!
    
    
    static let storyboardIdentifier = "FilmDetailsViewController"
    var id = Int()
    
    private let network = NetworkRequest.shared
    
    var filmsDetails = [FilmDetailsModel]() {
        didSet {
            DispatchQueue.main.async {
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        network.loadDetailsData(id: id, completion:{ [weak self] data in
        self?.filmsDetails = data
            self?.setupViewDetails()
        })
    }
    
    func setupViewDetails() {
        backDropPathImage.imageFromServerURL(filmsDetails[0].backdropPath)
        originalTitleLabel?.text = filmsDetails[0].title
        genresLabel?.text = filmsDetails[0].genres
        overviewLabel?.text = filmsDetails[0].overview
        releaseDataLabel?.text = filmsDetails[0].releaseDate
        let roudPopularity = filmsDetails[0].popularity.rounded()
        popularityLabel?.text = String(roudPopularity)
    }
    
}
