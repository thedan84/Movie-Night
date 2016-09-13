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

enum Option {
    case Actor, Genre
}

class ActorTableViewController: UITableViewController {
    
    //MARK: - Properties
    let movieManager = MovieManager()
    var typeArray = [MovieType]()
    var page = 1
    var typesSelected = [MovieType]()
    var limitOfSelections = 5
    var selectedOption: Option?

    //MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.registerNib(UINib(nibName: tableViewNibName, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        
        if let option = self.selectedOption {
            switch option {
            case .Actor:
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
                
                self.tableView.addInfiniteScrollingWithHandler {
                    self.movieManager.fetchPopularPeople(withPage: self.page, completion: { (people, error) in
                        if let actors = people {
                            self.typeArray += actors
                            self.page += 1
                        } else if let error = error {
                            AlertManager.showAlertWith(title: "There appears to be a problem", message: "\(error)", inViewController: self)
                        }
                        self.tableView.infiniteScrollingView?.stopAnimating()
                        self.tableView.flashScrollIndicators()
                        self.tableView.reloadData()
                    })
                }
            case .Genre:
                self.title = "Genres"
                movieManager.fetchGenres({ (genres, error) in
                    if let genres = genres {
                        self.typeArray += genres
                    } else if let error = error {
                        AlertManager.showAlertWith(title: "There appears to be a problem", message: "\(error)", inViewController: self)
                    }
                    self.tableView.reloadData()
                })
            }
        }

        let searchVC = SearchTableViewController()
        searchVC.searchController = UISearchController(searchResultsController: searchVC)
        searchVC.searchController.searchResultsUpdater = searchVC
        tableView.tableHeaderView = searchVC.searchController.searchBar
        searchVC.searchController.searchBar.delegate = searchVC
        self.definesPresentationContext = true
                
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
    }
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        var type = typeArray[indexPath.row]
        
        type.selected = !type.selected
        typeArray[indexPath.row] = type
        
        if typesSelected.count < limitOfSelections {
            if type.selected {
                typesSelected.append(type)
            } else if !type.selected {
                for (index, selectedType) in typesSelected.enumerate() {
                    if selectedType.id == type.id {
                        typesSelected.removeAtIndex(index)
                    }
                }
            }
        } else if typesSelected.count == limitOfSelections {
            for (index, selectedType) in typesSelected.enumerate() {
                if selectedType.id == type.id {
                    typesSelected.removeAtIndex(index)
                }
            }
        } else {
            return nil
        }
        
        tableView.reloadData()
        
        switch typesSelected.count {
        case 0:
            if let option = self.selectedOption {
                switch option {
                case .Actor: self.title = "Actors"
                case .Genre: self.title = "Genres"
                }
            }
        case 1...limitOfSelections: self.title = "\(typesSelected.count)/5 selected"
        default: break
        }
        
        return indexPath
    }
}