//
//  DetailViewController.swift
//  Fix
//
//  Created by Thalia Villalobos on 2/5/18.
//  Copyright © 2018 Thalia Villalobos. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var backDropImageView: UIImageView!
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    @IBOutlet weak var overViewLabel: UILabel!
    
    var movie: Movie!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let movie = movie{
            titleLabel.text = movie.title
            releaseDateLabel.text = movie.releaseDate
            overViewLabel.text = movie.overviewLabel
            backDropImageView.af_setImage(withURL: movie.backDropPathString!)
            posterImageView.af_setImage(withURL: movie.posterUrl!)
            
        }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let trailerViewController = segue.destination as! TrailerViewController
        trailerViewController.movie = movie
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    


}
