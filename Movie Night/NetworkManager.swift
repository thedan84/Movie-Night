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
    case Movie = "movie"
    
    private var apiKey: String {
        return "c3005ad5132be3f614b8de0fe58fbdf4"
    }
    
    private var baseURL: String {
        return "https://api.themoviedb.org/3/"
    }
    
    func URL(withQueryString queryString: String) -> NSURL {
        let finalString = queryString.stringByReplacingOccurrencesOfString(" ", withString: "-")
        
        return NSURL(string: baseURL + "search/\(self.rawValue)?api_key=\(apiKey)&query=\(finalString)")!
    }
}

enum APIResult {
    case Success(AnyObject)
    case Failure(ErrorType)
}

struct NetworkManager {
    private let session = NSURLSession(configuration: .defaultSessionConfiguration())
    
    func requestEndpoint(endpoint: Endpoint, withQueryString queryString: String, completion: (result: APIResult) -> Void) {
        let request = NSURLRequest(URL: endpoint.URL(withQueryString: queryString))
        
        let task = session.dataTaskWithRequest(request) { (data, response, error) in
            if let error = error {
                completion(result: .Failure(error))
            } else  if let data = data {
                if let json = try? NSJSONSerialization.JSONObjectWithData(data, options: []) {
                    switch json {
                    case let result as JSONDict: completion(result: .Success(result))
                    case let result as JSONArray: completion(result: .Success(result))
                    default: break
                    }
                }
            }
        }
        task.resume()
    }
}