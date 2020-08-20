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
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
