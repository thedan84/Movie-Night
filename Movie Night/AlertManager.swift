//
//  AlertManager.swift
//  Movie Night
//
//  Created by Dennis Parussini on 10-09-16.
//  Copyright © 2016 Dennis Parussini. All rights reserved.
//

import UIKit

//Helper struct to display an alert when there's an error
struct AlertManager {
    static func showAlertWith(_ title: String, message: String, inViewController viewController: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(okAction)
        
        viewController.present(alert, animated: true, completion: nil)
    }
}
