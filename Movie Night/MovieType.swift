//
//  MovieType.swift
//  Movie Night
//
//  Created by Dennis Parussini on 22-07-16.
//  Copyright © 2016 Dennis Parussini. All rights reserved.
//

import Foundation

//MARK: - Type enum
enum Type {
    case movie, actor
}

//MARK: - MovieType protocol to which every object has to conform
protocol MovieType {
    var type: Type { get }
    var id: Int? { get }
    var selected: Bool { get set }
    
    init?(json: JSONDict)
}
