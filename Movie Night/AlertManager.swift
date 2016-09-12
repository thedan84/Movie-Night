//
//  AlertManager.swift
//  Movie Night
//
//  Created by Dennis Parussini on 10-09-16.
//  Copyright © 2016 Dennis Parussini. All rights reserved.
//

import UIKit

struct AlertManager {
    static func showAlertWith(title title: String, message: String, inViewController viewController: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        
        alert.addAction(okAction)
        
        viewController.presentViewController(alert, animated: true, completion: nil)
    }
}