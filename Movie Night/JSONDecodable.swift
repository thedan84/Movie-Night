//
//  JSONDecodable.swift
//  Movie Night
//
//  Created by Dennis Parussini on 20-07-16.
//  Copyright © 2016 Dennis Parussini. All rights reserved.
//

import Foundation

protocol JSONDecodable {
//    static func createFromJSON(json: JSONDict) -> Self?
    init?(json: JSONDict)
}