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
    var movie: [String: Any]?
    
    var id: String = ""
    let key = ""
    let youtubeURL = "https://www.youtube.com/watch?v="
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let movie = movie {
            let idNum = movie["id"] as! Int
            self.id = String(idNum)
            print(id)
        }
        
        fetchMovies()
    }

    func fetchMovies() {
        let url = URL(string: "https://api.themoviedb.org/3/movie/" + self.id + "/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US")!
        
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns.
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                let movies = dataDictionary["results"] as! [[String: Any]]
                self.trailer = movies
                print(movies)
                
                let officialTrailer = self.trailer[0]
                let key = officialTrailer["key"] as! String
                
                
                let youtubeLink = self.youtubeURL + key
                //print(type(of:youtubeLink))
                
                let requestURL = URL(string: youtubeLink)
                //print(type(of:requestURL))
                
                let request = URLRequest(url: requestURL!)
                //print(type(of:request))
                
                self.webView.loadRequest(request)
            }
        }
        task.resume()
    }
    
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   

}
