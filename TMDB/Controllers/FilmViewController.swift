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
    
    var loadingData = false
    private let utilites = Utilities.sharedUtilities
    private let network = NetworkRequest.shared
    let storyboardIdentifier = "FilmDetailsViewController"
    var filmsManager = FilmsManager()
    var currentPage : Int = 1
    var isLoadingList : Bool = false
    
    var films = [FilmModel]() {
        didSet {
            DispatchQueue.main.async {
                self.myTableView.reloadData()
            }
        }
    }
    var category = K.CurrentCategory.popular
    
    
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
        filmsManager.loadSegmentData(index: 0, pageNum: 1)
        
    }
    
    @IBAction func didChangeSegment(_ sender: UISegmentedControl) {
        let nextPage = (films.count / 20) + 1
        filmsManager.loadSegmentData(index: sender.selectedSegmentIndex, pageNum: nextPage)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let filmDetailsViewController = storyboard.instantiateViewController(identifier: storyboardIdentifier) as? FilmDetailsViewController {
            filmDetailsViewController.id = self.films[indexPath.row].id
            present(filmDetailsViewController, animated: true)
        }
    }
    
    func loadMoreItemsForList() {
        if isLoadingList {
            return
        }
        isLoadingList = !isLoadingList
        currentPage = (films.count / 20) + 1
        network.loadData(category, pageNum: currentPage, completion: { (films) in
            if films.count > 0 {
                self.films =  self.films + films
            }
            self.isLoadingList = !self.isLoadingList
        })
        print(currentPage)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        if distanceFromBottom < height {
            loadMoreItemsForList()
        }
    }
}
