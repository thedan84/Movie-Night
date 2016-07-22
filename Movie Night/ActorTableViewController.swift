//
//  ActorTableViewController.swift
//  Movie Night
//
//  Created by Dennis Parussini on 21-07-16.
//  Copyright © 2016 Dennis Parussini. All rights reserved.
//

import UIKit

class ActorTableViewController: UITableViewController {

    let movieManager = MovieManager()
    var actors = [Person]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        movieManager.fetchPopularPeople { (people, error) in
            if let actors = people {
                self.actors += actors
                self.tableView.reloadData()
            } else if let error = error {
                print(error)
            }
        }
        
        self.tableView.registerNib(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieCell")
        
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    // MARK: - Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return actors.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MovieCell", forIndexPath: indexPath) as! MovieTableViewCell

        let actor = actors[indexPath.row]
        cell.configureWithMovieType(actor)

        return cell
    }
}
