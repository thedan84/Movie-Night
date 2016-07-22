//
//  Person.swift
//  Movie Night
//
//  Created by Dennis Parussini on 13-07-16.
//  Copyright © 2016 Dennis Parussini. All rights reserved.
//

import UIKit

struct Person: MovieType {
    let id: Int?
    let name: String?
    let profileImageURL: String?
    
    init?(json: JSONDict) {
        guard let name = json["name"] as? String, let id = json["id"] as? Int, let profilePath = json["profile_path"] as? String else { return nil }
        
        self.name = name
        self.id = id
        self.profileImageURL = profilePath
    }
}