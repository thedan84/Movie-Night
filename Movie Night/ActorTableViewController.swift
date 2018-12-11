//
//  ActorTableViewController.swift
//  Movie Night
//
//  Created by Dennis Parussini on 21-07-16.
//  Copyright © 2016 Dennis Parussini. All rights reserved.
//

import UIKit
import ICSPullToRefresh

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
        
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(dismissView))
        self.navigationItem.leftBarButtonItem = cancelButton
        
        self.tableView.register(UINib(nibName: tableViewNibName, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        
        self.title = "Actors"
        
        movieManager.fetchPopularPeople(withPage: self.page) { (people, error) in
            if let error = error {
                AlertManager.showAlertWith("There appears to be a problem", message: error.localizedDescription, inViewController: self)
            } else if let actors = people {
                self.typeArray += actors
                self.page += 1
            }
            self.tableView.reloadData()
        }
        
        tableView.addInfiniteScrollingWithHandler {
            self.movieManager.fetchPopularPeople(withPage: self.page) { (people, error) in
                if let error = error {
                    AlertManager.showAlertWith("There appears to be a problem", message: error.localizedDescription, inViewController: self)
                } else if let actors = people {
                    self.typeArray += actors
                    self.page += 1
                }
                self.tableView.reloadData()
                self.tableView.infiniteScrollingView?.stopAnimating()
            }
        }

        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 120
        self.tableView.allowsMultipleSelection = true
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return typeArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MovieTableViewCell
        
        let type = typeArray[indexPath.row]
        cell.configureWithMovieType(type)
        
        if type.selected {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        var type = typeArray[indexPath.row]
        
        type.selected = !typeArray[indexPath.row].selected
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
                for (index, typeSelected) in user1Choices.enumerated() {
                    if typeSelected.id == type.id {
                        user1Choices.remove(at: index)
                    }
                }
            } else if user1Choices.count == limitOfSelections && user2Choices.count < limitOfSelections {
                for (index, typeSelected) in user2Choices.enumerated() {
                    if typeSelected.id == type.id {
                        user2Choices.remove(at: index)
                    }
                }
            }
            numberOfRowsSelected -= 1
        }
        
        tableView.reloadData()
        
        if numberOfRowsSelected < limitOfSelections {
            doneButton.isEnabled = false
        } else {
            doneButton.isEnabled = true
        }
        
        switch numberOfRowsSelected {
        case 0: self.title = "Actors"
        case 1...limitOfSelections: self.title = "\(numberOfRowsSelected)/5 selected"
        default: break
        }
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if numberOfRowsSelected < limitOfSelections {
            return indexPath
        } else {
            return nil
        }
    }
    
    //MARK: - Action methods
    @IBAction func doneButtonTapped(_ sender: UIBarButtonItem) {
        if user2Choices.count < limitOfSelections {
            let actorVC = storyboard?.instantiateViewController(withIdentifier: "ActorTableView") as! ActorTableViewController
            actorVC.user1Choices = self.user1Choices
            navigationController?.pushViewController(actorVC, animated: true)
        } else if user1Choices.count == limitOfSelections && user2Choices.count == limitOfSelections {
            let movieVC = storyboard?.instantiateViewController(withIdentifier: "MovieTableView") as! MovieTableViewController
            movieVC.userChoices = self.intersectArray(user1Choices, andArray: user2Choices)
            navigationController?.pushViewController(movieVC, animated: true)
        }
    }
    
    //MARK: - Helper methods
    fileprivate func intersectArray(_ array1: [MovieType], andArray array2: [MovieType]) -> String {
        var finalChoices = String()
        
        for int1 in array1 {
            for int2 in array2 {
                if int1.id == int2.id {
                    finalChoices += "\(int1.id!)" + ","
                }
            }
        }
        return finalChoices
    }
    
    @objc func dismissView() {
        self.dismiss(animated: true, completion: nil)
    }
}
