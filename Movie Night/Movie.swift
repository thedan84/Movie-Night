//
//  Movie.swift
//  Movie Night
//
//  Created by Dennis Parussini on 13-07-16.
//  Copyright © 2016 Dennis Parussini. All rights reserved.
//

import Foundation

struct Movie: MovieType {
    let overview: String?
    let releaseDate: NSDate?
    let id: Int?
    let title: String?
    let posterImageURL: String?
    
    init?(json: JSONDict) {
        guard let overview = json["overview"] as? String, let releaseDateString = json["release_date"] as? String, let id = json["id"] as? Int, let title = json["title"] as? String, let posterImageURL = json["poster_path"] as? String else { return nil }
        
        self.overview = overview
        self.releaseDate = dateFormatter.dateFromString(releaseDateString)
        self.id = id
        self.title = title
        self.posterImageURL = posterImageURL
    }
}