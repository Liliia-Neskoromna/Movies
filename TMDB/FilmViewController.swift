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

class FilmViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, FilmsManagerDelegate {
    
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var segmentControll: UISegmentedControl!
    
    var filmsManager = FilmsManager()
    var films = [FilmModel]() {
        didSet {
            DispatchQueue.main.async {
                self.myTableView.reloadData()
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
        
        let nib = UINib.init(nibName: K.nibName, bundle: nil)
        self.myTableView.register(nib, forCellReuseIdentifier: K.cellIdentifire)
        
        myTableView.dataSource = self
        myTableView.delegate = self
        filmsManager.delegate = self
        filmsManager.loadSegmentData(index: 0)
    }
    
    @IBAction func didChangeSegment(_ sender: UISegmentedControl) {
        filmsManager.loadSegmentData(index: sender.selectedSegmentIndex)
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return films.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = myTableView.dequeueReusableCell(withIdentifier: K.cellIdentifire, for: indexPath) as! FilmCustomCell
        
        cell.titleLabel?.text = self.films[indexPath.row].title
        cell.backDropImage.imageFromServerURL(self.films[indexPath.row].posterPath)
        cell.overviewLabel?.text = self.films[indexPath.row].overview
        
        return cell
    }
}
