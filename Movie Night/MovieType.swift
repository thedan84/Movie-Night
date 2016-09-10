//
//  MovieType.swift
//  Movie Night
//
//  Created by Dennis Parussini on 22-07-16.
//  Copyright © 2016 Dennis Parussini. All rights reserved.
//

import Foundation

enum Type {
    case Movie, Actor, Genre
}

protocol MovieType {
    var type: Type { get }
    var id: Int? { get }
    var selected: Bool { get set }
    
    init?(json: JSONDict)
}