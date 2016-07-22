//
//  MovieType.swift
//  Movie Night
//
//  Created by Dennis Parussini on 22-07-16.
//  Copyright © 2016 Dennis Parussini. All rights reserved.
//

import Foundation

protocol MovieType {
    init?(json: JSONDict)
}