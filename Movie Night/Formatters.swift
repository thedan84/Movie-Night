//
//  DateFormatter.swift
//  Movie Night
//
//  Created by Dennis Parussini on 13-07-16.
//  Copyright © 2016 Dennis Parussini. All rights reserved.
//

import Foundation

let dateFormatter: NSDateFormatter = {
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "MM/dd/yyyy"
    return dateFormatter
}()

extension Array {

    func convertToMovieString() -> String {
        var finalString = String()
        
        for int in self {
            finalString += "\(int)".stringByAppendingString(",")
        }
        
        return finalString
    }
}