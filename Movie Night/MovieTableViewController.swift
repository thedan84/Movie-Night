//
//  MovieTableViewController.swift
//  Movie Night
//
//  Created by Dennis Parussini on 19-09-16.
//  Copyright © 2016 Dennis Parussini. All rights reserved.
//

import UIKit

//MARK: - Constants
private let tableViewNibName = "MovieTableViewCell"
private let cellIdentifier = "MovieCell"

class MovieTableViewController: UITableViewController {
    
    //MARK: - Properties
    let movieManager = MovieManager()
    var userChoices: String?
    var movieArray = [MovieType]()

    //MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: UIView())
        let startOverButton = UIBarButtonItem(title: "Start Over", style: .done, target: self, action: #selector(startOver))
        self.navigationItem.rightBarButtonItem = startOverButton
        
        tableView.register(UINib(nibName: tableViewNibName, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        
        movieManager.fetchMoviesWithCast(containing: userChoices!) { (movies, error) in
            if movies!.count < 1 {
                let alert = UIAlertController(title: "Oops", message: "I couldn't find a match with your choices. Please start over.", preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: "OK", style: .default, handler: { (okAction) in
                    self.dismiss(animated: true, completion: nil)
                })
                
                alert.addAction(okAction)
                
                self.present(alert, animated: true, completion: nil)
            } else if let movies = movies {
                self.title = "Movies"
                self.movieArray += movies
                self.tableView.reloadData()
            }
        }
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 120
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MovieTableViewCell

        let movie = movieArray[(indexPath as NSIndexPath).row]
        cell.configureWithMovieType(movie)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = movieArray[(indexPath as NSIndexPath).row]
        let movieVC = storyboard?.instantiateViewController(withIdentifier: "MovieVC") as! MovieViewController
        movieVC.movie = movie
        navigationController?.pushViewController(movieVC, animated: true)
    }
    
    //MARK: - Helper methods
    @objc func startOver() {
        self.dismiss(animated: true, completion: nil)
    }
}
