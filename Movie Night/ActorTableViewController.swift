//
//  ActorTableViewController.swift
//  Movie Night
//
//  Created by Dennis Parussini on 21-07-16.
//  Copyright © 2016 Dennis Parussini. All rights reserved.
//

import UIKit

//MARK: - Constants
private let tableViewNibName = "MovieTableViewCell"
private let cellIdentifier = "MovieCell"

class ActorTableViewController: UITableViewController {
    
    //MARK: - Properties
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    var movieManager = MovieManager()
    var typeArray = [MovieType]()
    var limitOfSelections = 5
    var numberOfRowsSelected = Int()
    var page = 1
    var user1Choices = [MovieType]()
    var user2Choices = [MovieType]()

    //MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .Plain, target: self, action: #selector(dismiss))
        self.navigationItem.leftBarButtonItem = cancelButton
        
        self.tableView.registerNib(UINib(nibName: tableViewNibName, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        
        self.title = "Actors"
        
        movieManager.fetchPopularPeople(withPage: self.page) { (people, error) in
            if let error = error {
                AlertManager.showAlertWith(title: "There appears to be a problem", message: error.localizedDescription, inViewController: self)
            } else if let actors = people {
                self.typeArray += actors
                self.page += 1
            }
            self.tableView.reloadData()
        }
        
        tableView.addInfiniteScrollingWithHandler {
            self.movieManager.fetchPopularPeople(withPage: self.page) { (people, error) in
                if let error = error {
                    AlertManager.showAlertWith(title: "There appears to be a problem", message: error.localizedDescription, inViewController: self)
                } else if let actors = people {
                    self.typeArray += actors
                    self.page += 1
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
            if user1Choices.count < limitOfSelections {
                user1Choices.append(type)
            } else if user1Choices.count == limitOfSelections && user2Choices.count < limitOfSelections {
                user2Choices.append(type)
            }
            numberOfRowsSelected += 1
        } else {
            if user1Choices.count < limitOfSelections {
                for (index, typeSelected) in user1Choices.enumerate() {
                    if typeSelected.id == type.id {
                        user1Choices.removeAtIndex(index)
                    }
                }
            } else if user1Choices.count == limitOfSelections && user2Choices.count < limitOfSelections {
                for (index, typeSelected) in user2Choices.enumerate() {
                    if typeSelected.id == type.id {
                        user2Choices.removeAtIndex(index)
                    }
                }
            }
            numberOfRowsSelected -= 1
        }
        
        tableView.reloadData()
        
        if numberOfRowsSelected < limitOfSelections {
            doneButton.enabled = false
        } else {
            doneButton.enabled = true
        }
        
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
    
    //MARK: - Action methods
    @IBAction func doneButtonTapped(sender: UIBarButtonItem) {
        if user2Choices.count < limitOfSelections {
            let actorVC = storyboard?.instantiateViewControllerWithIdentifier("ActorTableView") as! ActorTableViewController
            actorVC.user1Choices = self.user1Choices
            navigationController?.pushViewController(actorVC, animated: true)
        } else if user1Choices.count == limitOfSelections && user2Choices.count == limitOfSelections {
            let movieVC = storyboard?.instantiateViewControllerWithIdentifier("MovieTableView") as! MovieTableViewController
            movieVC.userChoices = self.intersectArray(user1Choices, andArray: user2Choices)
            navigationController?.pushViewController(movieVC, animated: true)
        }
    }
    
    //MARK: - Helper methods
    private func intersectArray(array1: [MovieType], andArray array2: [MovieType]) -> String {
        var finalChoices = String()
        
        for int1 in array1 {
            for int2 in array2 {
                if int1.id == int2.id {
                    finalChoices += "\(int1.id!)".stringByAppendingString(",")
                }
            }
        }
        return finalChoices
    }
    
    func dismiss() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
