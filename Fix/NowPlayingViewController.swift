//
//  NowPlayingViewController.swift
//  Fix
//
//  Created by Thalia Villalobos on 1/31/18.
//  Copyright © 2018 Thalia Villalobos. All rights reserved.
//

import UIKit
import AlamofireImage


class NowPlayingViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    //List of Movies
    var movies: [[String: Any]] = []
    var refreshControl: UIRefreshControl!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl = UIRefreshControl()
        
        refreshControl.addTarget(self, action: #selector(NowPlayingViewController.didPullToRefresh(_:)), for: .valueChanged)
        
        tableView.insertSubview(refreshControl, at: 0)
        
        tableView.dataSource = self
        fetchMovies()
    }
    
    func didPullToRefresh(_ refreshControl: UIRefreshControl){
        fetchMovies()
    }
    
    //Getting the infomation
    func fetchMovies(){
        //API Setup
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        
        let request = URLRequest(url: url, cachePolicy: .reloadRevalidatingCacheData, timeoutInterval: 10)
        
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        
        let task = session.dataTask(with: request){(data, response, error) in
            //This will run whe the network request returns
            if let error = error{
                print(error.localizedDescription)
            }else if let data = data{
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                let movies = dataDictionary["results"] as! [[String: Any]]
                self.movies = movies
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
        
        task.resume()
    }
        
    
    
    
    //The number of cells
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    
    //Dislaying the information from API
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        
        let movie = movies[indexPath.row]
        let title = movie["title"] as! String
        let overview = movie["overview"] as! String
        let posterPathString = movie["poster_path"] as! String
        let baseURLString = "https://image.tmdb.org/t/p/w500"
        let posterURL  = URL(string: baseURLString + posterPathString)!
        
        
        cell.titleLabel.text = title
        cell.overviewLabel.text = overview
        cell.posterImageView.af_setImage(withURL: posterURL)
        
        return cell
    }


    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
