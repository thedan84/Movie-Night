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
    
    let imageLoader = ImageLoader()
    
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
            
            if let url = person.profileImageURL {
                self.imageLoader.requestImageDownloadForURL(url) { (image) in
                    if let image = image {
                        self.posterImageView.image = image
                    } else {
                        self.posterImageView.image = nil
                    }
                }
            }
            
        case let movie as Movie:
            if let title = movie.title {
                self.titleLabel.text = title
            }
            
            if let imageURL = movie.posterImageURL {
                self.imageLoader.requestImageDownloadForURL(imageURL) { (image) in
                    if let image = image {
                        self.posterImageView.image = image
                    } else {
                        self.posterImageView.image = nil
                    }
                }
            }
        default: break
        }
    }
}
