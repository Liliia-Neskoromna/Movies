//
//  ViewController.swift
//  TMDB
//
//  Created by Lilia on 8/19/20.
//  Copyright © 2020 Liliia. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

//enum CurrentSegmentType: String {
//    case popular, upcoming, topRated
//    
//    var urlString: String {
//        switch self {
//        case .popular:
//            return "https://api.themoviedb.org/3/movie/popular?api_key=76984f3d864f02cb288e53d24f6e7d6b&language=ru-Ru&page=1"
//        case .topRated:
//            return "https://api.themoviedb.org/3/movie/top_rated?api_key=76984f3d864f02cb288e53d24f6e7d6b&language=ru-Ru&page=1"
//        default:
//            return "https://api.themoviedb.org/3/movie/upcoming?api_key=76984f3d864f02cb288e53d24f6e7d6b&language=ru-Ru&page=1"
//        }
//    }
//}

class FilmViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var filmTableView: UITableView!
    
    let kReUseId = "cellForFilms"
    
    //доробити
    //let params: [String: String] = ["api-key": "kcZPVVrUr4PUmXGnWGT8trQK1pe7A7mX"]
    var films = [Any]()
    //        [FilmModel]() {
    //        didSet {
    //            DispatchQueue.main.async {
    //                self.tableView.reloadData()
    //            }
    //        }
    //    }
//    var currentControllerType: CurrentSegmentType = .upcoming
    
    
    override func viewDidAppear(_ animated: Bool) {
        let nav = self.navigationController?.navigationBar
        
        nav?.barStyle = UIBarStyle.black
        nav?.tintColor = UIColor.clear
        nav?.topItem?.title = "TMDB"
        nav?.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.cyan]
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.filmTableView.register(FilmTableViewCell.self, forCellReuseIdentifier: kReUseId)
        
        
    }
    @IBAction func didChangeSegment(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            view.backgroundColor = .black
        }
        else if sender.selectedSegmentIndex == 1 {
            view.backgroundColor = .black
        }
        else if sender.selectedSegmentIndex == 2 {
            view.backgroundColor = .black
        }
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return films.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = filmTableView.dequeueReusableCell(withIdentifier: kReUseId,
                                                            for: indexPath) as? FilmTableViewCell else {fatalError("Bad Cell")}
        
//        cell.titleLabel?.text = self.articles[indexPath.row].title
//        cell.detailsLabel?.text = self.articles[indexPath.row].abstract
//        cell.imageArt.imageFromServerURL(self.articles[indexPath.row].image)
//        cell.favButton.index = indexPath.row
//        cell.favButton.isSelected = self.articles[indexPath.row].isSelected
        
        return cell
    }
    
}

