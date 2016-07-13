//
//  ViewController.swift
//  Movie Night
//
//  Created by Dennis Parussini on 13-07-16.
//  Copyright © 2016 Dennis Parussini. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let manager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        manager.requestEndpoint(.Person, withQueryString: "Tom Hanks") { (result) in
            switch result {
            case .Success(let json):
                let jsonDict = json["results"] as? JSONArray
                for json in jsonDict! {
                    let person = Person(json: json)
                    print(person!.name)
                }
            case .Failure(let error):
                print(error)
            }
        }
        
    }
}

