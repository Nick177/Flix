//
//  PosterCell.swift
//  Fix
//
//  Created by Mario Martinez on 2/1/18.
//  Copyright © 2018 Thalia Villalobos. All rights reserved.
//

import UIKit

class PosterCell: UICollectionViewCell {
    
    @IBOutlet weak var posterImageView: UIImageView!
    var movie: Movie! {
        didSet {
            posterImageView.af_setImage(withURL: movie.posterUrl!)
        }
    }
}
