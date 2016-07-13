//
//  Person.swift
//  Movie Night
//
//  Created by Dennis Parussini on 13-07-16.
//  Copyright © 2016 Dennis Parussini. All rights reserved.
//

import Foundation

struct Person {
    let id: Int?
    let name: String?
    
    init?(json: JSONDict) {
        guard let name = json["name"] as? String, let id = json["id"] as? Int else { return nil }
        
        self.name = name
        self.id = id
    }
}