//
//  FilmCustomCell.swift
//  TMDB
//
//  Created by Lilia on 8/20/20.
//  Copyright © 2020 Liliia. All rights reserved.
//

import UIKit

class FilmCustomCell: UITableViewCell {
    
    @IBOutlet weak var backDropImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
//    override func addConstraint(_ constraint: NSLayoutConstraint) {
//        backDropImage.addConstraint(<#T##constraint: NSLayoutConstraint##NSLayoutConstraint#>)
//    
    
}
