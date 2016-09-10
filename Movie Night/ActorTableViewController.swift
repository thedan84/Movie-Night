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
    
    //MARK: - Properties
    let movieManager = MovieManager()
    var actors = [MovieType]()
    var page = 1
    var actorsSelected = [MovieType]()
    var limitOfSelections = 5

    //MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.registerNib(UINib(nibName: tableViewNibName, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        
        movieManager.fetchPopularPeople(withPage: self.page) { (people, error) in
            if let actors = people {
                self.actors += actors
            }
            self.tableView.reloadData()
        }
        
//        loadInitialSetOfActors()
//
//        self.tableView.addInfiniteScrollingWithHandler { 
//            self.loadMoreActors(withPage: self.page)
//        }
        
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.allowsMultipleSelection = true
    }

    // MARK: - Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return actors.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! MovieTableViewCell

        let actor = actors[indexPath.row]
        cell.configureWithMovieType(actor)
        
        if actor.selected {
            cell.checkboxImageView.image = UIImage(named: "bubble-selected")
        } else {
            cell.checkboxImageView.image = UIImage(named: "bubble-empty")
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        var actor = actors[indexPath.row]
        actor.selected = !actor.selected
        
        actors[indexPath.row] = actor
        
        if actor.selected {
            actorsSelected.append(actor)
        } else {
            for selectedActor in actorsSelected {
                if actor.id == selectedActor.id {
                    self.actorsSelected.removeAtIndex(indexPath.row)
                }
            }
            
        }
        
        print(actorsSelected.count)
        
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
    
    //MARK: - Helper methods
//    private func loadInitialSetOfActors() {
//        movieManager.fetchPopularPeople(withPage: self.page) { (people, error) in
//            if let actors = people as? [Actor] {
//                self.actors += actors
//                self.page += 1
//            } else if let error = error {
//                print(error)
//            }
//            self.tableView.reloadData()
//        }
//    }
    
//    private func loadMoreActors(withPage page: Int) {
//        self.movieManager.fetchPopularPeople(withPage: page, completion: { (people, error) in
//            if let actors = people as? [Person] {
//                self.actors += actors
//                self.page += 1
//            } else if let error = error {
//                print(error)
//            }
//            self.tableView.infiniteScrollingView?.stopAnimating()
//            self.tableView.flashScrollIndicators()
//            self.tableView.reloadData()
//        })
//    }
}