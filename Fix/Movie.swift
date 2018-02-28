//
//  Movie.swift
//  Fix
//
//  Created by Thalia Villalobos on 2/28/18.
//  Copyright © 2018 Thalia Villalobos. All rights reserved.
//

import Foundation
class Movie{
    var title: String
    var posterUrl: URL?
    var overviewLabel: String
    let baseURLString = "https://image.tmdb.org/t/p/w500"
    var backDropPathString: URL?
    var releaseDate: String
    var id: String

    
    
    init(dictionary: [String: Any]) {
        title = dictionary["title"] as? String ?? "No title"
        posterUrl = URL(string: baseURLString + (dictionary["poster_path"] as! String))
        overviewLabel = dictionary["overview"] as! String
        backDropPathString = URL(string:baseURLString + (dictionary["backdrop_path"] as! String))
        releaseDate = dictionary["release_date"] as! String
        id = dictionary ["id"] as! String
        // Set the rest of the properties
    }
    
    //helper function to Movie
    class func movies(dictionaries: [[String: Any]]) -> [Movie] {
        var movies: [Movie] = []
        for dictionary in dictionaries {
            let movie = Movie(dictionary: dictionary)
            movies.append(movie)
        }
        
        return movies
    }
    


}
