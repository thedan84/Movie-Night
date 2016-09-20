//
//  MovieManager.swift
//  Movie Night
//
//  Created by Dennis Parussini on 19-07-16.
//  Copyright © 2016 Dennis Parussini. All rights reserved.
//

import Foundation

struct MovieManager {
    
    //MARK: - Properties
    private let networkManager = NetworkManager()
    
    var user1Choices = [MovieType]()
    var user2Choices = [MovieType]()

    //MARK: - Methods
    //This method fetches the movies regarding to the choices the users made
    func fetchMoviesWithCast(containing cast: String, completion: (movies: [MovieType]?, error: NSError?) -> Void) {
        self.networkManager.requestEndpoint(.Movies, withQueryString: cast) { (result) in
            switch result {
            case .Success(let object):
                JSONParser.parse(json: object, forMovieType: .Movie, completion: { (movieType) in
                    completion(movies: movieType, error: nil)
                })
            case .Failure(let error): completion(movies: nil, error: error)
            }
        }
    }
    
    //This method fetches the most popular people, and paginates the API
    func fetchPopularPeople(withPage page: Int, completion: (people: [MovieType]?, error: NSError?) -> Void) {
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
}
