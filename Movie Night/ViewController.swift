//
//  ViewController.swift
//  Movie Night
//
//  Created by Dennis Parussini on 13-07-16.
//  Copyright © 2016 Dennis Parussini. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let manager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        manager.requestEndpoint(.Person, withQueryString: "Tom Hanks") { (result) in
//            switch result {
//            case .Success(let json):
//                for jsonDict in json as! JSONArray {
//                    let person = Person(json: jsonDict)
//                    print(person!.name)
//                }
//            case .Failure(let error):
//                print(error)
//            }
//        }
        
        let intArray = [1810, 3894]
        
        let finalString = intArray.convertToMovieString()
        
        manager.requestEndpoint(.Movie, withQueryString: finalString) { (result) in
            switch result {
            case .Success(let object):
                for jsonDict in object as! JSONArray {
                    let movie = Movie(json: jsonDict)
                    print(movie!.title)
                }
                
            case .Failure(let error): print(error)
            }
        }
        
    }
}

