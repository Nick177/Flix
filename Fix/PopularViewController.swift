//
//  PopularViewController.swift
//  Fix
//
//  Created by Mario Martinez on 3/2/18.
//  Copyright © 2018 Thalia Villalobos. All rights reserved.
//

import UIKit

class PopularViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //List of Movies
    //var movies: [[String: Any]] = []
    var movies: [Movie] = []
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        
        refreshControl = UIRefreshControl()
        
        refreshControl.addTarget(self, action: #selector(PopularViewController.didPullToRefresh(_:)), for: .valueChanged)
        
        tableView.insertSubview(refreshControl, at: 0)
        
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50
        
        
        
        fetchMovies()
        activityIndicator.stopAnimating()
    }
    
    func didPullToRefresh(_ refreshControl: UIRefreshControl){
        fetchMovies()
        refreshControl.endRefreshing()
    }
    
    //Getting the infomation
    func fetchMovies(){
        MovieApiManager().popularMovies(completion: {(movies: [Movie]?, error: Error?) in
            if let movies = movies {
                self.movies = movies
                self.tableView.reloadData()
            }
            
        })
    }
    
    
    //The number of cells
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    
    //Dislaying the information from API
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        
        cell.movie = movies[indexPath.row]
        return cell
    }
    
    
    //Moving a movie info to DetailViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let cell = sender as! UITableViewCell
        if let indexPath = tableView.indexPath(for: cell) {
            let movie = movies[indexPath.row]
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.movie = movie
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
