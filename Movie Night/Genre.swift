//
//  Genre.swift
//  Movie Night
//
//  Created by Dennis Parussini on 20-07-16.
//  Copyright © 2016 Dennis Parussini. All rights reserved.
//

import Foundation

struct Genre: MovieType {
    let id: Int?
    let name: String?
    
    init?(json: JSONDict) {
        guard let id = json["id"] as? Int, let name = json["name"] as? String else { return nil }
        
        self.id = id
        self.name = name
    }
}