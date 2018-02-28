//
//  TrailerViewController.swift
//  Fix
//
//  Created by Thalia  on 2/11/18.
//  Copyright © 2018 Thalia Villalobos. All rights reserved.
//

import UIKit

class TrailerViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    var trailer: [[String: Any]] = []
    var movie: Movie!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchMovies()
    }
//ToDo:******************
    func fetchMovies() {
        MovieApiManager().trailerPlaying(completion: {(movies: URLRequest, error: Error?) in
//            if let movies = movies {
//                self.movies = movies
//                self.tableView.reloadData()
//            }
            
        })
    }
    
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   

}
