//
//  MovieViewController.swift
//  Movie Night
//
//  Created by Dennis Parussini on 19-09-16.
//  Copyright © 2016 Dennis Parussini. All rights reserved.
//

import UIKit
import Nuke

class MovieViewController: UIViewController {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var movie: MovieType?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let movie = movie as? Movie, let posterURL = movie.posterImageURL, let title = movie.title, let overview = movie.overview {
            self.posterImageView.nk_setImageWith(posterURL)
            self.titleLabel.text = title
            self.descriptionLabel.text = overview
        }
    }
}
