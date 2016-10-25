//
//  DateFormatter.swift
//  Movie Night
//
//  Created by Dennis Parussini on 13-07-16.
//  Copyright © 2016 Dennis Parussini. All rights reserved.
//

import Foundation

//An extension on Array to convert the array of user's choices to a String
extension Array {
    func convertToMovieString() -> String {
        var finalString = String()
        
        for int in self {
            finalString += "\(int)" + ","
        }
        
        return finalString
    }
}
