//
//  MovieManager.swift
//  Movie Night
//
//  Created by Dennis Parussini on 19-07-16.
//  Copyright © 2016 Dennis Parussini. All rights reserved.
//

import Foundation

struct MovieManager {
    private let networkManager = NetworkManager()
    
    var people = [Person]()
        
    func fetchMoviesWithCast(cast: [Int], completion: (movies: [Movie]?, error: ErrorType?) -> Void) {
        self.networkManager.requestEndpoint(.Movie, withQueryString: cast.convertToMovieString()) { (result) in
            switch result {
            case .Success(let object):
                if let results = object["results"] as? JSONArray {
                    var movies = [Movie]()
                    for json in results {
                        if let movie = Movie(json: json) {
                            movies.append(movie)
                        }
                    }
                    completion(movies: movies, error: nil)
                }
                
            case .Failure(let error): completion(movies: nil, error: error)
            }
        }
    }
    
    mutating func fetchPersonWithName(name: String, completion: (person: Person?, error: ErrorType?) -> Void) {
        self.networkManager.requestEndpoint(.Person, withQueryString: name) { (result) in
            switch result {
            case .Success(let object):
                if let results = object["results"] as? JSONArray {
                    var personObject: Person!
                    for json in results {
                        if let person = Person(json: json) {
                            personObject = person
                        }
                        completion(person: personObject, error: nil)
                    }
                }
                
            case .Failure(let error): completion(person: nil, error: error)
            }
        }
    }
    
    func fetchGenres(completion: (genres: [Genre]?, error: ErrorType?) -> Void) {
        self.networkManager.requestEndpoint(.Genre, withQueryString: nil) { (result) in
            switch result {
            case .Success(let object):
                if let results = object["genres"] as? JSONArray {
                    var genres = [Genre]()
                    for json in results {
                        if let genre = Genre(json: json) {
                            genres.append(genre)
                        }
                    }
                    completion(genres: genres, error: nil)
                }
                
            case.Failure(let error): completion(genres: nil, error: error)
            }
        }
    }
}