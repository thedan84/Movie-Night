//
//  MovieTableViewCell.swift
//  Movie Night
//
//  Created by Dennis Parussini on 22-07-16.
//  Copyright © 2016 Dennis Parussini. All rights reserved.
//

import UIKit
import Nuke

class MovieTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    //MARK: - View lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        self.posterImageView.image = nil
    }
    
    //MARK: - Cell configuration
    func configureWithMovieType(movieType: MovieType) {
        switch movieType {
        case let person as Actor:
            
            if let url = person.profileImageURL {
                self.posterImageView.nk_setImageWith(url)
                if let name = person.name {
                    self.titleLabel.text = name
                }
            }
            
        case let movie as Movie:
            if let url = movie.posterImageURL {
                self.posterImageView.nk_setImageWith(url)
                if let title = movie.title {
                    self.titleLabel.text = title
                }
            }
        default: break
        }
    }
}
