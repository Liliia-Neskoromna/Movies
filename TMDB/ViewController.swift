//
//  ViewController.swift
//  TMDB
//
//  Created by Lilia on 8/19/20.
//  Copyright © 2020 Liliia. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var filmTableView: UITableView!
    
    
    let kReUseId = "cellForFilms"
    var films = [Any]()
    //        [FilmModel]() {
    //        didSet {
    //            DispatchQueue.main.async {
    //                self.tableView.reloadData()
    //            }
    //        }
    //    }
    
    
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

