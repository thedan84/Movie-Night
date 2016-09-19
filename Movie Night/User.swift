//
//  User.swift
//  Movie Night
//
//  Created by Dennis Parussini on 13-09-16.
//  Copyright © 2016 Dennis Parussini. All rights reserved.
//

import Foundation

struct User {
    var selections: [MovieType]
    
    init(selections: [MovieType]) {
        self.selections = selections
    }
}
