//
//  MainTabBarProtocol.swift
//  Test1
//
//  Created by Masoud Heydari on 10/25/18.
//  Copyright © 2018 Masoud Heydari. All rights reserved.
//

import UIKit

protocol MainTabBarDelegate: class {
}

protocol TableViewItemSelectionDelegate: class {
    func tableViewClicked(indexPath: IndexPath, province: String)
}
