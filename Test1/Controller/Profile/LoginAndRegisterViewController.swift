//
//  LoginAndRegisterController.swift
//  Test1
//
//  Created by Masoud Heydari on 10/22/18.
//  Copyright © 2018 Masoud Heydari. All rights reserved.
//

import UIKit

class LoginAndRegisterViewController: UIViewController {
    let label: UILabel = {
        let label = UILabel()
        label.text = "بخش 'ورود کاربر' بزودی بروز رسانی می شود"
        label.textColor = .darkRedLight
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupNavBar()
    }
    
    private func setupViews(){
        self.view.backgroundColor = .white
        view.addSubview(label)
        
        label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }
    
    private func setupNavBar(){
        navigationItem.title = "ورود کاربر"
    }
}
