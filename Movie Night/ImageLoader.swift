//
//  ImageLoader.swift
//  Movie Night
//
//  Created by Dennis Parussini on 24-07-16.
//  Copyright © 2016 Dennis Parussini. All rights reserved.
//

import UIKit

struct ImageLoader {
    func requestImageDownloadForURL(url: String, completion: (image: UIImage?) -> Void) {
        if let url = NSURL(string: "https://image.tmdb.org/t/p/w92\(url)") {
            if let data = NSData(contentsOfURL: url) {
                if let image = UIImage(data: data) {
                    completion(image: image)
                }
            }
        }
    }
}