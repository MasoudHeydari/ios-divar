//
//  CustomNavigationControllerViewController.swift
//  Test1
//
//  Created by Masoud Heydari on 10/13/18.
//  Copyright © 2018 Masoud Heydari. All rights reserved.
//

import UIKit

class CustomNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavController()
        
    }
    
    public func setupNavController() {
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.darkRedLight]
        navigationBar.isTranslucent = false
        navigationBar.tintColor = .darkRedLight
        
    }
    
}
