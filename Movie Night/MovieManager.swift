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
    fileprivate let networkManager = NetworkManager()
    
    var user1Choices = [MovieType]()
    var user2Choices = [MovieType]()

    //MARK: - Methods
    //This method fetches the movies regarding to the choices the users made
    func fetchMoviesWithCast(containing cast: String, completion: @escaping (_ movies: [MovieType]?, _ error: NSError?) -> Void) {
        self.networkManager.requestEndpoint(.Movies, withQueryString: cast) { (result) in
            switch result {
            case .success(let object):
                JSONParser.parse(json: object as AnyObject, forMovieType: .movie, completion: { (movieType) in
                    completion(movieType, nil)
                })
            case .failure(let error): completion(nil, error)
            }
        }
    }
    
    //This method fetches the most popular people, and paginates the API
    func fetchPopularPeople(withPage page: Int, completion: @escaping (_ people: [MovieType]?, _ error: NSError?) -> Void) {
        self.networkManager.requestEndpoint(.PopularPeople, withQueryString: "\(page)") { (result) in
            switch result {
            case .success(let object):
                JSONParser.parse(json: object as AnyObject, forMovieType: .actor, completion: { (people) in
                    completion(people, nil)
                })
            case .failure(let error): completion(nil, error)
            }
        }
    }
}
