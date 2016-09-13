//
//  SearchTableViewController.swift
//  Movie Night
//
//  Created by Dennis Parussini on 13-09-16.
//  Copyright © 2016 Dennis Parussini. All rights reserved.
//

import UIKit

private let tableViewNibName = "MovieTableViewCell"
private let cellIdentifier = "MovieCell"

class SearchTableViewController: UITableViewController, UISearchControllerDelegate, UISearchBarDelegate, UISearchResultsUpdating {
    
    let movieManager = MovieManager()
    var searchController: UISearchController!
    var filteredActors = [MovieType]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerNib(UINib(nibName: tableViewNibName, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
    }

    // MARK: - Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredActors.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! MovieTableViewCell

        let actor = filteredActors[indexPath.row]
        cell.configureWithMovieType(actor)

        return cell
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filterActors()
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        self.filteredActors.removeAll()
    }
    
    func filterActors() {
        if let searchString = self.searchController.searchBar.text?.stringByReplacingOccurrencesOfString(" ", withString: ",") {
            movieManager.fetchPersonWithName(searchString) { (people, error) in
                if let people = people {
                    self.filteredActors += people
                    self.tableView.reloadData()
                }
            }
        }
    }
}
