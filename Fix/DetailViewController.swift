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
    
    var movie: [String: Any]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let movie = movie{
            titleLabel.text = movie["title"] as? String
            releaseDateLabel.text = movie ["release_date"] as? String
            overViewLabel.text = movie["overview"] as? String
            
            let backDropPathString = movie["backdrop_path"] as! String
            
            let posterPathString = movie["poster_path"] as! String
            
            let baseURLString = "https://image.tmdb.org/t/p/w500"
            
            let backdropURL = URL(string: baseURLString + backDropPathString)!
                backDropImageView.af_setImage(withURL: backdropURL)
            
            let posterPathURL = URL(string: baseURLString + posterPathString)!
                posterImageView.af_setImage(withURL: posterPathURL)
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
