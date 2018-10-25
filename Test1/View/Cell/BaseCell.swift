//
//  BaseCell.swift
//  Test1
//
//  Created by Masoud Heydari on 10/13/18.
//  Copyright © 2018 Masoud Heydari. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    
    let dividerLine: UIView = {
        let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = UIColor.Gray.light1
        return line
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupView() {
        backgroundColor = .cyan
        clipsToBounds = true
        
        addSubview(dividerLine)
        backgroundColor = .white
        dividerLine.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        dividerLine.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        dividerLine.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        dividerLine.heightAnchor.constraint(equalToConstant: 0.8).isActive = true
    }
    
}
