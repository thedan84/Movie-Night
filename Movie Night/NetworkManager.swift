//
//  NetworkManager.swift
//  Movie Night
//
//  Created by Dennis Parussini on 13-07-16.
//  Copyright © 2016 Dennis Parussini. All rights reserved.
//

import Foundation

typealias JSONDict = [String: AnyObject]
typealias JSONArray = [JSONDict]

enum Endpoint: String {
    case Person = "person"
    case Movies = "movie"
    case Genre = "genre"
    case PopularPeople = "person/popular"
    
    private var apiKey: String {
        return "c3005ad5132be3f614b8de0fe58fbdf4"
    }
    
    private var baseURL: String {
        return "https://api.themoviedb.org/3/"
    }
    
    func URL(withQueryString queryString: String?) -> NSURL {
        
        switch self {
        case .Person:
            let personString = queryString!.stringByReplacingOccurrencesOfString(" ", withString: ",")
            return NSURL(string: baseURL + "search/\(self.rawValue)?query=\(personString)&api_key=\(apiKey)")!
        case .Movies: return NSURL(string: baseURL + "discover/\(self.rawValue)?with_cast=\(queryString!)&api_key=\(apiKey)")!
        case .Genre: return NSURL(string: baseURL + "genre/movie/list?api_key=\(apiKey)")!
        case .PopularPeople: return NSURL(string: baseURL + "\(self.rawValue)?api_key=\(apiKey)")!
        }
    }
}

enum APIResult {
    case Success(AnyObject)
    case Failure(ErrorType)
}

struct NetworkManager {
    private let session = NSURLSession(configuration: .defaultSessionConfiguration())
    
    func requestEndpoint(endpoint: Endpoint, withQueryString queryString: String?, completion: (result: APIResult) -> Void) {
        let request = NSURLRequest(URL: endpoint.URL(withQueryString: queryString))
        
        let task = session.dataTaskWithRequest(request) { (data, response, error) in
            NSOperationQueue.mainQueue().addOperationWithBlock {
                if let error = error {
                    completion(result: .Failure(error))
                } else if let data = data {
                    if let json = try? NSJSONSerialization.JSONObjectWithData(data, options: []) {
                        switch json  {
                        case let object as JSONArray: completion(result: .Success(object))
                        case let object as JSONDict: completion(result: .Success(object))
                        default: break
                        }
                    }
                }
            }
        }
        task.resume()
    }
}