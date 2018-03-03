//
//  SuperheroViewController.swift
//  Fix
//
//  Created by Mario Martinez on 2/1/18.
//  Copyright © 2018 Thalia Villalobos. All rights reserved.
//

import UIKit

class SuperheroViewController: UIViewController, UICollectionViewDataSource {

    @IBOutlet var collectionView: UICollectionView!
    
    var movies: [Movie]!//[[String: Any]] = []
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        
        //Storyboard layout
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = layout.minimumInteritemSpacing
        let cellsPerLine: CGFloat = 2
        let interItemsSpacingTotal = layout.minimumInteritemSpacing * (cellsPerLine - 1)
        let width = collectionView.frame.size.width / cellsPerLine - interItemsSpacingTotal / cellsPerLine
        
        layout.itemSize = CGSize (width: width, height: width * 3/2)
        
        
        
        fetchMovies()
      
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if movies != nil {
            return movies.count
        } else {
            return 0
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PosterCell", for: indexPath) as! PosterCell
        

        cell.movie = movies[indexPath.row]
        return cell
    }
    
    //Moving a movie info to DetailViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let cell = sender as! UICollectionViewCell
        if let indexPath = collectionView.indexPath(for: cell) {
            let movie = movies[indexPath.row]
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.movie = movie
            }
    }


    
    func fetchMovies(){

        MovieApiManager().superheroMovies { (movies: [Movie]?, error: Error?) in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                self.movies = movies
                self.collectionView.reloadData()
            }
        }
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
