//
//  ViewController.swift
//  Movie Night
//
//  Created by Dennis Parussini on 13-07-16.
//  Copyright © 2016 Dennis Parussini. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var user1: User?
    var user2: User?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
        
    @IBAction func tapToEnterPreferencesButtonTapped(sender: UIButton) {
        switch sender.tag {
        case 1:
            let alert = UIAlertController(title: "Choose option", message: "Would you like to search for movies based on actors or genres?", preferredStyle: .Alert)
            
            let actorAction = UIAlertAction(title: "Actor", style: .Default, handler: { (actorAction) in
                let movieVC = self.storyboard?.instantiateViewControllerWithIdentifier("MovieTableView") as! ActorTableViewController
                movieVC.selectedOption = .Actor
                self.navigationController?.pushViewController(movieVC, animated: true)
            })
            
            let genreAction = UIAlertAction(title: "Genre", style: .Default, handler: { (genreAction) in
                let movieVC = self.storyboard?.instantiateViewControllerWithIdentifier("MovieTableView") as! ActorTableViewController
                movieVC.selectedOption = .Genre
                self.navigationController?.pushViewController(movieVC, animated: true)
            })
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
            
            alert.addAction(actorAction)
            alert.addAction(genreAction)
            alert.addAction(cancelAction)
            
            self.presentViewController(alert, animated: true, completion: nil)
        case 2: break
        default: break
        }
    }
}