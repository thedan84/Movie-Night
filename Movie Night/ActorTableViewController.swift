//
//  ActorTableViewController.swift
//  Movie Night
//
//  Created by Dennis Parussini on 21-07-16.
//  Copyright © 2016 Dennis Parussini. All rights reserved.
//

import UIKit

private let tableViewNibName = "MovieTableViewCell"
private let cellIdentifier = "MovieCell"

class ActorTableViewController: UITableViewController {
    
    //MARK: - Properties
    let movieManager = MovieManager()
    var typeArray = [MovieType]()
    var typesSelected = [MovieType]()
    var limitOfSelections = 5
    var numberOfRowsSelected = Int()
    var page = 1

    //MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.registerNib(UINib(nibName: tableViewNibName, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        
        self.title = "Actors"
        
        movieManager.fetchPopularPeople(withPage: self.page) { (people, error) in
            if let actors = people {
                self.typeArray += actors
                self.page += 1
            } else if let error = error {
                AlertManager.showAlertWith(title: "There appears to be a problem", message: "\(error)", inViewController: self)
            }
            self.tableView.reloadData()
        }
        
        tableView.addInfiniteScrollingWithHandler { 
            self.movieManager.fetchPopularPeople(withPage: self.page) { (people, error) in
                if let actors = people {
                    self.typeArray += actors
                    self.page += 1
                } else if let error = error {
                    AlertManager.showAlertWith(title: "There appears to be a problem", message: "\(error)", inViewController: self)
                }
                self.tableView.reloadData()
                self.tableView.infiniteScrollingView?.stopAnimating()
            }
        }

        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        self.tableView.allowsMultipleSelection = true
    }

    // MARK: - Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return typeArray.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! MovieTableViewCell
        
        let type = typeArray[indexPath.row]
        cell.configureWithMovieType(type)
        
        if type.selected {
            cell.accessoryType = .Checkmark
        } else {
            cell.accessoryType = .None
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        var type = typeArray[indexPath.row]
        
        type.selected = !type.selected
        typeArray[indexPath.row] = type
        
        if type.selected {
            typesSelected.append(type)
            numberOfRowsSelected += 1
        } else {
            for (index, typeSelected) in typesSelected.enumerate() {
                if typeSelected.id == type.id {
                    typesSelected.removeAtIndex(index)
                }
            }
            numberOfRowsSelected -= 1
        }
        
        tableView.reloadData()
        
        switch numberOfRowsSelected {
        case 0: self.title = "Actors"
        case 1...limitOfSelections: self.title = "\(numberOfRowsSelected)/5 selected"
        default: break
        }
    }
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        if numberOfRowsSelected < limitOfSelections {
            return indexPath
        } else {
            return nil
        }
    }
}
