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

    func fetchMoviesWithCast(cast: [Int], completion: (movies: [MovieType]?, error: ErrorType?) -> Void) {
        self.networkManager.requestEndpoint(.Movies, withQueryString: cast.convertToMovieString()) { (result) in
            switch result {
            case .Success(let object):
                JSONParser.parse(json: object, forMovieType: .Movie, completion: { (movieType) in
                    completion(movies: movieType, error: nil)
                })
            case .Failure(let error): completion(movies: nil, error: error)
            }
        }
    }
    
    func fetchPersonWithName(name: String, completion: (people: [MovieType]?, error: ErrorType?) -> Void) {
        self.networkManager.requestEndpoint(.Person, withQueryString: name) { (result) in
            switch result {
            case .Success(let object):
                JSONParser.parse(json: object, forMovieType: .Actor, completion: { (movieType) in
                    completion(people: movieType, error: nil)
                })
            case .Failure(let error): completion(people: nil, error: error)
            }
        }
    }
    
    func fetchPopularPeople(withPage page: Int, completion: (people: [MovieType]?, error: ErrorType?) -> Void) {
        self.networkManager.requestEndpoint(.PopularPeople, withQueryString: "\(page)") { (result) in
            switch result {
            case .Success(let object):
                JSONParser.parse(json: object, forMovieType: .Actor, completion: { (people) in
                    completion(people: people, error: nil)
                })
            case .Failure(let error): completion(people: nil, error: error)
            }
        }
    }

    func fetchGenres(completion: (genres: [MovieType]?, error: ErrorType?) -> Void) {
        self.networkManager.requestEndpoint(.Genre, withQueryString: nil) { (result) in
            switch result {
            case .Success(let object):
                JSONParser.parse(json: object, forMovieType: .Genre, completion: { (movieType) in
                    completion(genres: movieType, error: nil)
                })
            case.Failure(let error): completion(genres: nil, error: error)
            }
        }
    }
}