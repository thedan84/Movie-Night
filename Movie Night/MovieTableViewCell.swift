//
//  MovieTableViewCell.swift
//  Movie Night
//
//  Created by Dennis Parussini on 22-07-16.
//  Copyright © 2016 Dennis Parussini. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    let networkManager = NetworkManager()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configureWithMovieType(movieType: MovieType) {
        switch movieType {
        case let person as Person:
            
            if let name = person.name {
                self.titleLabel.text = name
            }
            
            if let url = NSURL(string: "https://image.tmdb.org/t/p/w185\(person.profileImageURL!)") {
                if let data = NSData(contentsOfURL: url) {
                    if let image = UIImage(data: data) {
                        NSOperationQueue.mainQueue().addOperationWithBlock({
                            self.posterImageView.image = image
                        })
                    }
                }
            }
            
        case let movie as Movie:
            if let imageURL = movie.posterImageURL {
                if let imageData = NSData(contentsOfURL: NSURL(string: imageURL)!) {
                    self.posterImageView.image = UIImage(data: imageData)
                }
                
                if let title = movie.title {
                    self.titleLabel.text = title
                }
            }
        default: break
        }
    }
    
}
