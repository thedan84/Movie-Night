//
//  ViewController.swift
//  Movie Night
//
//  Created by Dennis Parussini on 13-07-16.
//  Copyright © 2016 Dennis Parussini. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var movieManager = MovieManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let intArray = [1810, 3894, 1810]
        
//        self.movieManager.fetchMoviesWithCast(intArray) { (movies, error) in
//            if let movies = movies {
//                print(movies)
//            } else if let error = error {
//                print(error)
//            }
//            
//        }
        
        let searchString = "Chr"
        
        self.movieManager.fetchPersonWithName(searchString) { (person, error) in
            if let person = person {
                print(person)
            } else if let error = error {
                print(error)
            }
        }
        
    }
}

