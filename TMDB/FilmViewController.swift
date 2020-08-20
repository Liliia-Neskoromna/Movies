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

class FilmViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var filmTableView: UITableView!
    @IBOutlet weak var segmentControll: UISegmentedControl!
    
    let kReUseId = "cellForFilms"
    
    let network = NetworkRequest.shared
    var films = [FilmModel]() {
            didSet {
                DispatchQueue.main.async {
                    self.filmTableView.reloadData()
                }
            }
        }    
    
    override func viewDidAppear(_ animated: Bool) {
        let nav = self.navigationController?.navigationBar
        
        nav?.barStyle = UIBarStyle.black
        nav?.tintColor = UIColor.clear
        nav?.topItem?.title = "TMDB"
        nav?.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.cyan]
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.filmTableView.register(FilmTableViewCell.self, forCellReuseIdentifier: kReUseId)
        filmTableView.dataSource = self
        filmTableView.delegate = self
        
//        network.loadData(completion: { [weak self] data in
//            self?.films = data
//            print(self?.films as Any)
//            self?.filmTableView.reloadData()
//        })
    }
    
    @IBAction func didChangeSegment(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            view.backgroundColor = .black
            network.loadData(completion: { [weak self] data in
            self?.films = data
            })
        }
        else if sender.selectedSegmentIndex == 1 {
            view.backgroundColor = .red
        }
        else if sender.selectedSegmentIndex == 2 {
            view.backgroundColor = .green
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
        
        cell.titleLabel?.text = self.films[indexPath.row].title
        cell.posterImage.imageFromServerURL(self.films[indexPath.row].posterPath)
        cell.discriptionLabel?.text = self.films[indexPath.row].overview
        
        return cell
    }
    
}

