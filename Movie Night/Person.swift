//
//  Person.swift
//  Movie Night
//
//  Created by Dennis Parussini on 13-07-16.
//  Copyright © 2016 Dennis Parussini. All rights reserved.
//

import UIKit

struct Actor: MovieType {
    
    //MARK: - Properties
    let id: Int?
    let name: String?
    let profileImageURL: URL?
    var selected = false
    let type = Type.actor
    
    //MARK: - Initialization
    init?(json: JSONDict) {
        guard let name = json["name"] as? String, let id = json["id"] as? Int, let profilePath = json["profile_path"] as? String else { return nil }
        
        self.name = name
        self.id = id
        if let imageURL = URL(string: "https://image.tmdb.org/t/p/w185\(profilePath)") {
            self.profileImageURL = imageURL
        } else {
            self.profileImageURL = nil
        }
    }
}
