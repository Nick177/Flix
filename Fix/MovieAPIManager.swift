//
//  MovieAPIManager.swift
//  Fix
//
//  Created by Thalia Villalobos on 2/28/18.
//  Copyright © 2018 Thalia Villalobos. All rights reserved.
//

import Foundation

class MovieApiManager {
    
    static let baseUrl = "https://api.themoviedb.org/3/movie/"
    static let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
    static let youtubeURL = "https://www.youtube.com/watch?v="

    var session: URLSession
    var movie: Movie!
    var trailer: [[String: Any]] = []


    
    init() {
        session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
    }
    
    func nowPlayingMovies(completion: @escaping ([Movie]?, Error?) -> ()) {
        let url = URL(string: MovieApiManager.baseUrl + "now_playing?api_key=\(MovieApiManager.apiKey)")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                let movieDictionaries = dataDictionary["results"] as! [[String: Any]]
                
                let movies = Movie.movies(dictionaries: movieDictionaries)
                completion(movies, nil)
            } else {
                completion(nil, error)
            }
        }
        task.resume()
    }
  
    //ToDo:******************

    func trailerPlaying(completion: @escaping(URLRequest, Error?) -> ()) {
        let url = URL(string: "https://api.themoviedb.org/3/movie/" + movie.id + "/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US")!
        
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
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
                
                let youtubeLink = MovieApiManager.youtubeURL + key
                //print(type(of:youtubeLink))
                
                let requestURL = URL(string: youtubeLink)
                //print(type(of:requestURL))
                
                let request = URLRequest(url: requestURL!)
                //print(type(of:request))
                 completion(request,nil)
               // self.webView.loadRequest(request)
            }
        }
        task.resume()
    }
}
