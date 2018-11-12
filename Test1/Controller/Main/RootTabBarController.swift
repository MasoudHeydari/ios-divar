//
//  ViewController.swift
//  Test1
//
//  Created by Masoud Heydari on 10/12/18.
//  Copyright © 2018 Masoud Heydari. All rights reserved.
//

import UIKit

class RootTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    var menuButtonFrame = CGRect()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupTabBars()
        
    }
    
    private func setupViews(){
        delegate = self
        tabBar.isTranslucent = false
        tabBar.tintColor = .darkRedLight
        tabBar.barTintColor = .milkyWhite
    }
    
    private func setupTabBars() {
        let layout = UICollectionViewFlowLayout()
        let allAdvertisingsController = AllAdvertisingsController(collectionViewLayout: layout)
        let allAdvertisingsNavController = CustomNavigationController(rootViewController: allAdvertisingsController)
        allAdvertisingsNavController.tabBarItem.title = Const.TabBarTitle.allAdvertising
        allAdvertisingsNavController.tabBarItem.image = UIImage(named: Const.Image.advertising)
        
        let profileController = ProfileTabController()
        let profileNavController = CustomNavigationController(rootViewController: profileController)
        profileNavController.tabBarItem.title = Const.TabBarTitle.profile
        profileNavController.tabBarItem.image = UIImage(named: Const.Image.userProfileBorder)
        
        let newAdvertising = NewAdvertisingController()
        let newAdvertisingNavController = CustomNavigationController(rootViewController: newAdvertising)
        newAdvertisingNavController.tabBarItem.title = Const.TabBarTitle.newAdvertising
        
        viewControllers = [
            profileNavController,
            newAdvertisingNavController,
            allAdvertisingsNavController
        ]
        
        setupMiddleButton()
        // when app open, first screen that show up, is AllAdvertisingController
        // added by : Masoud Heydari    10 NOV 2018   09:15  AM
        selectedIndex = 2
    }
    
    func setupMiddleButton() {
        let menuButton = UIButton()
        menuButton.frame = CGRect(x: 0, y: 0, width: 65, height: 65)
        
        let img = UIImage(named: Const.Image.plus)
        menuButton.setImage(img, for: .normal)
        menuButton.backgroundColor = .darkRedLight
        menuButton.layer.cornerRadius = 32
        menuButton.adjustsImageWhenHighlighted = false
        menuButtonFrame = menuButton.frame
        
        var y: CGFloat = 0
        let x = (view.bounds.width / 2) - (menuButtonFrame.size.width / 2)
        
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.keyWindow
            let bottomPadding = window?.safeAreaInsets.bottom
            guard let bottomPaddingUnwrapped = bottomPadding else { return }
            y = tabBar.frame.origin.y - menuButtonFrame.height / 2 - bottomPaddingUnwrapped
        }else {
            y = tabBar.frame.origin.y - menuButtonFrame.height / 2
        }
        
        menuButtonFrame.origin.y = y
        menuButtonFrame.origin.x = x
        
        menuButton.frame = menuButtonFrame
        view.addSubview(menuButton)
        menuButton.addTarget(self, action: #selector(menuButtonAction(sender:)), for: .touchUpInside)
        view.layoutIfNeeded()
        
    }
    
    @objc private func menuButtonAction(sender: UIButton) {
        selectedIndex = 1
    }
    
    // this method prevent tab bar from doplicate ....
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        navigationController?.popToRootViewController(animated: true)
        return viewController != tabBarController.selectedViewController
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if viewController.isKind(of: UINavigationController.self) {
            (viewController as? UINavigationController)?.popToRootViewController(animated: false)
        }
    }
    
}

