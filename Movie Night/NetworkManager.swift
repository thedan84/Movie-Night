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
        let personString = queryString.stringByReplacingOccurrencesOfString(" ", withString: "-")
        
        switch self {
        case .Person: return NSURL(string: baseURL + "search/\(self.rawValue)?api_key=\(apiKey)&query=\(personString)")!
        case .Movie: return NSURL(string: baseURL + "discover/\(self.rawValue)?api_key=\(apiKey)&with_cast=\(queryString)")!
        }
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
                if let json = try? NSJSONSerialization.JSONObjectWithData(data, options: []) as? JSONDict {
                    print(json)
                    if let results = json!["results"] as? JSONArray {
                        completion(result: .Success(results))
                    }
                }
            }
        }
        task.resume()
    }
}