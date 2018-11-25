//
//  Alert+Helper.swift
//  Test1
//
//  Created by Masoud Heydari on 11/24/18.
//  Copyright © 2018 Masoud Heydari. All rights reserved.
//

import Foundation
import UIKit

class Alert {
    
    /// this function show a basic alert with a button and title and description.
    ///
    /// - Parameters:
    ///   - btnTitle: title for alert button
    ///   - title: alert title
    ///   - message: alert description
    ///   - vc: view controller that you are in.
    // added by: Masoud Heydari   24 NOV 2018   09:03 AM
    class func showBasic(btnTitle: String, title: String, message: String, vc: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: btnTitle, style: .default, handler: nil))
        vc.present(alert, animated: true)
    }
}
