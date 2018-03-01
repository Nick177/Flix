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
    var movie: Movie!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchMovies()
    }
//ToDo:******************
    func fetchMovies() {
        MovieApiManager().trailerPlaying(id: self.movie.id, completion: {(urlrequest: URLRequest?, error: Error?) in
           if let request = urlrequest {
                //self.movie = movies
                self.webView.loadRequest(request)
            }
            
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
