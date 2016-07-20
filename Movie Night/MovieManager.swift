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
            self.parseJSONResult(result) { (object, error) in
                if let object = object as? JSONArray {
                    var movies = [Movie]()
                    for json in object {
                        if let movie = Movie(json: json) {
                            movies.append(movie)
                        }
                    }
                    completion(movies: movies, error: nil)
                } else if let error = error {
                    completion(movies: nil, error: error)
                }
            }
        }
    }
    
    mutating func fetchPersonWithName(name: String, completion: (person: Person?, error: ErrorType?) -> Void) {
        self.networkManager.requestEndpoint(.Person, withQueryString: name) { (result) in
            self.parseJSONResult(result) { (object, error) in
                if let object = object as? JSONArray {
                    for json in object {
                        if let person = Person(json: json) {
                            self.people.append(person)
                            completion(person: person, error: nil)
                        }
                    }
                } else if let error = error {
                    completion(person: nil, error: error)
                }
            }
        }
    }
    
    func fetchGenres(completion: (genres: [Genre]) -> Void) {
        self.networkManager.requestEndpoint(.Genre, withQueryString: nil) { (result) in
            print(result)
            self.parseJSONResult(result, completion: { (object, error) in
                if let object = object as? JSONArray {
                    print(object)
                    var genres = [Genre]()
                    for json in object {
                        if let genre = Genre.createFromJSON(json) {
                            genres.append(genre)
                        }
                    }
                    completion(genres: genres)
                }
            })
        }
    }
    
    private func parseJSONResult(result: APIResult, completion: (object: AnyObject?, error: ErrorType?) -> Void) {
        switch result {
        case .Failure(let error):
            completion(object: nil, error: error)
        case .Success(let jsonArray):
            var object = [AnyObject]()
            for json in jsonArray as! JSONArray {
                object.append(json)
            }
            completion(object: object, error: nil)
        }
    }
}