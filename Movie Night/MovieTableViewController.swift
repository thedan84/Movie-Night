//
//  MovieTableViewController.swift
//  Movie Night
//
//  Created by Dennis Parussini on 19-09-16.
//  Copyright © 2016 Dennis Parussini. All rights reserved.
//

import UIKit

private let tableViewNibName = "MovieTableViewCell"
private let cellIdentifier = "MovieCell"

class MovieTableViewController: UITableViewController {
    
    let movieManager = MovieManager()
    var userChoices: String?
    var movieArray = [MovieType]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerNib(UINib(nibName: tableViewNibName, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        
        movieManager.fetchMoviesWithCast(containing: userChoices!) { (movies, error) in
            self.movieArray += movies!
            print(movies)
            self.tableView.reloadData()
        }
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
    }

    // MARK: - Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieArray.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! MovieTableViewCell

        let movie = movieArray[indexPath.row]
        cell.configureWithMovieType(movie)

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let movie = movieArray[indexPath.row]
        let movieVC = storyboard?.instantiateViewControllerWithIdentifier("MovieVC") as! MovieViewController
        movieVC.movie = movie
        navigationController?.pushViewController(movieVC, animated: true)
    }
}
