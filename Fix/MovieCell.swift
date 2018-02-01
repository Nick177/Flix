//
//  MovieCell.swift
//  Fix
//
//  Created by Thalia Villalobos on 1/31/18.
//  Copyright © 2018 Thalia Villalobos. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {
    
    
    
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
