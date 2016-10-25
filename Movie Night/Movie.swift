//
//  Movie.swift
//  Movie Night
//
//  Created by Dennis Parussini on 13-07-16.
//  Copyright © 2016 Dennis Parussini. All rights reserved.
//

import Foundation

struct Movie: MovieType {
    
    //MARK: - Properties
    let overview: String?
    let id: Int?
    let title: String?
    let posterImageURL: URL?
    let type = Type.movie
    var selected = false
    
    //MARK: - Initialization
    init?(json: JSONDict) {
        guard let overview = json["overview"] as? String, let id = json["id"] as? Int, let title = json["title"] as? String, let posterImageURL = json["poster_path"] as? String else { return nil }
        
        self.overview = overview
        self.id = id
        self.title = title
        if let imageURL = URL(string: "https://image.tmdb.org/t/p/original\(posterImageURL)") {
            self.posterImageURL = imageURL
        } else {
            self.posterImageURL = nil
        }
    }
}
