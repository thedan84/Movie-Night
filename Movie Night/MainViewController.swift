//
//  ViewController.swift
//  Movie Night
//
//  Created by Dennis Parussini on 13-07-16.
//  Copyright © 2016 Dennis Parussini. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var matchMeButton: UIButton!

//    var user1: User?
//    var user2: User?
//    var selection: [MovieType]? {
//        didSet {
//            if user1 == nil {
//                user1 = User(selections: selection!)
//            } else if user2 == nil {
//                user2 = User(selections: selection!)
//                matchMeButton.enabled = true
//            }
//        }
//    }
    
    
    var selectionOfUser1: [MovieType]?
    var selectionOfUser2: [MovieType]?
    let movieManager = MovieManager()
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func matchMeButtonTapped(sender: UIButton) {
        print(selectionOfUser1)
        print(selectionOfUser2)
        
        
//        if let selectionOfUser1 = user1?.selections, let selectionsOfUser2 = user2?.selections {
//            var finalSelections = [Int]()
//            
//            for selection1 in selectionOfUser1 {
//                for selection2 in selectionsOfUser2 {
//                    if selection1.id == selection2.id {
//                        finalSelections.append(selection1.id!)
//                    }
//                }
//            }
//            print(finalSelections)
//        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let actorVC = (segue.destinationViewController as! UINavigationController).topViewController as! ActorTableViewController
    
        switch segue.identifier! {
        case "user1ToActorVC": actorVC.method = "user1"
        case "user2ToActorVC": actorVC.method = "user2"
        default: break
        }
    }
}
