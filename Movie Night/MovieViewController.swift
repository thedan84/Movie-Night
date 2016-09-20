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
    
    //MARK: - Properties
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var movie: MovieType?

    //MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        if let movie = movie as? Movie, let posterURL = movie.posterImageURL, let title = movie.title, let overview = movie.overview {
            self.posterImageView.nk_setImageWith(posterURL)
            self.title = title
            self.descriptionLabel.text = overview
        }
    }
}
