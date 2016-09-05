//
//  ActorTableViewController.swift
//  Movie Night
//
//  Created by Dennis Parussini on 21-07-16.
//  Copyright © 2016 Dennis Parussini. All rights reserved.
//

import UIKit
import ICSPullToRefresh

private let tableViewNibName = "MovieTableViewCell"
private let cellIdentifier = "MovieCell"

class ActorTableViewController: UITableViewController {

    let movieManager = MovieManager()
    var actors = [Person]()
    var page = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.registerNib(UINib(nibName: tableViewNibName, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        
        movieManager.fetchPopularPeople(withPage: 1) { (people, error) in
            if let actors = people {
                self.actors += actors
                self.page += 1
            } else if let error = error {
                print(error)
            }
            self.tableView.reloadData()
        }
        
        self.tableView.addInfiniteScrollingWithHandler { 
            self.movieManager.fetchPopularPeople(withPage: self.page, completion: { (people, error) in
                if let actors = people {
                    self.actors += actors
                    self.page += 1
                } else if let error = error {
                    print(error)
                }
                self.tableView.infiniteScrollingView?.stopAnimating()
                self.tableView.reloadData()
            })
        }
        
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    // MARK: - Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return actors.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! MovieTableViewCell

        let actor = actors[indexPath.row]
        cell.configureWithMovieType(actor)

        return cell
    }
}