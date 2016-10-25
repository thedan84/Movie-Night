//
//  NetworkManager.swift
//  Movie Night
//
//  Created by Dennis Parussini on 13-07-16.
//  Copyright © 2016 Dennis Parussini. All rights reserved.
//

import Foundation

//MARK: - Typealiases
typealias JSONDict = [String: AnyObject]
typealias JSONArray = [JSONDict]

//MARK: - Generating endpoints
enum Endpoint: String {
    case Person = "person"
    case Movies = "movie"
    case PopularPeople = "person/popular"
    
    fileprivate var apiKey: String {
        return "c3005ad5132be3f614b8de0fe58fbdf4"
    }
    
    fileprivate var baseURL: String {
        return "https://api.themoviedb.org/3/"
    }
    
    func URL(withQueryString queryString: String?) -> Foundation.URL {
        
        switch self {
        case .Person:
            let personString = queryString!.replacingOccurrences(of: " ", with: ",")
            return Foundation.URL(string: baseURL + "search/\(self.rawValue)?query=\(personString)&api_key=\(apiKey)")!
        case .Movies: return Foundation.URL(string: baseURL + "discover/\(self.rawValue)?with_cast=\(queryString!)&api_key=\(apiKey)")!
        case .PopularPeople: return Foundation.URL(string: baseURL + "\(self.rawValue)?page=\(queryString!)&api_key=\(apiKey)")!
        }
    }
}

//MARK: - APIResult enum
enum APIResult {
    case success(AnyObject)
    case failure(NSError)
}

//MARK: - NetworkManager struct
struct NetworkManager {
    fileprivate let session = URLSession(configuration: .default)
    
    func requestEndpoint(_ endpoint: Endpoint, withQueryString queryString: String?, completion: @escaping (APIResult) -> Void) {
        let request = URLRequest(url: endpoint.URL(withQueryString: queryString))
        
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
            OperationQueue.main.addOperation {
                if let error = error {
                    completion(.failure(error as NSError))
                } else if let data = data {
                    if let json = try? JSONSerialization.jsonObject(with: data, options: []) {
                        switch json {
                        case let object as JSONArray: completion(.success(object as AnyObject))
                        case let object as JSONDict: completion(.success(object as AnyObject))
                        default: break
                        }
                    }
                }
            }
        }) 
        task.resume()
    }
}
