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
    var typeSelected = [MovieType]()
    var limitOfSelections = 5
    var selectedOption: Option?

    //MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.registerNib(UINib(nibName: tableViewNibName, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        
        if let option = self.selectedOption {
            switch option {
            case .Actor:
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
        
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.allowsMultipleSelection = true
    }

    // MARK: - Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return typeArray.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! MovieTableViewCell
        
        if let option = self.selectedOption {
            switch option {
            case .Actor:
                let actor = typeArray[indexPath.row]
                cell.configureWithMovieType(actor)
                
                if actor.selected {
                    cell.checkboxImageView.image = UIImage(named: "bubble-selected")
                } else {
                    cell.checkboxImageView.image = UIImage(named: "bubble-empty")
                }
            case .Genre:
                let genre = typeArray[indexPath.row]
                cell.configureWithMovieType(genre)
            }
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        var actor = typeArray[indexPath.row]
        actor.selected = !actor.selected
        
        typeArray[indexPath.row] = actor
        
        if actor.selected {
            typeSelected.append(actor)
        } else {
            for selectedActor in typeSelected {
                if actor.id == selectedActor.id {
                    self.typeSelected.removeAtIndex(indexPath.row)
                }
            }
            
        }
        tableView.reloadData()
    }
    
//    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
//        var actor = actors[indexPath.row]
//        
//        actor.selected = !actor.selected
//        
//        if actorsSelected.count == limitOfSelections {
//            let alert = UIAlertController(title: "Oops", message: "You already selected \(limitOfSelections) actors. Please deselect one to select another one.", preferredStyle: .Alert)
//            
//            let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
//            
//            alert.addAction(okAction)
//            
//            self.presentViewController(alert, animated: true, completion: nil)
//            
//            return nil
//        } else if actorsSelected.count == limitOfSelections && actor.id == actors[indexPath.row].id {
//            actorsSelected.removeAtIndex(indexPath.row)
//            tableView.reloadData()
//            
//            return indexPath
//        }
//        
//        return indexPath
//    }
}