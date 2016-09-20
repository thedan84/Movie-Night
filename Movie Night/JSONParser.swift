//
//  JSONParser.swift
//  Movie Night
//
//  Created by Dennis Parussini on 10-09-16.
//  Copyright © 2016 Dennis Parussini. All rights reserved.
//

import Foundation

//Helper struct to parse incoming JSON data
struct JSONParser {
    static func parse(json json: AnyObject, forMovieType movieType: Type, completion: (movieType: [MovieType]) -> Void) {
        var movieTypeArray = [MovieType]()
        
        switch movieType {
        case .Movie:
            if let results = json["results"] as? JSONArray {
                for json in results {
                    if let movie = Movie(json: json) {
                        movieTypeArray.append(movie)
                    }
                }
            }
        case .Actor:
            if let results = json["results"] as? JSONArray {
                for json in results {
                    if let person = Actor(json: json) {
                        movieTypeArray.append(person)
                    }
                }
            }
        }
        completion(movieType: movieTypeArray)
    }
}
