//
//  pop.swift
//  Test1
//
//  Created by Masoud Heydari on 11/3/18.
//  Copyright © 2018 Masoud Heydari. All rights reserved.
//

import UIKit

class PopupChooseLocationTableViewCell: UITableViewCell {
    
    var province: String?  {
        didSet {
            if let province = province {
                self.provinceLabel.text = province
            }
        }
    }
    
    let provinceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.backgroundColor = .white
        return label
    }()
    
    let divider: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.Gray.light2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.selectionStyle = .none
        addSubview(provinceLabel)
        addSubview(divider)
        
        provinceLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12).isActive = true
        provinceLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12).isActive = true
        provinceLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 2).isActive = true
        provinceLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        divider.leftAnchor.constraint(equalTo: self.provinceLabel.leftAnchor).isActive = true
        divider.rightAnchor.constraint(equalTo: self.provinceLabel.rightAnchor).isActive = true
        divider.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        divider.heightAnchor.constraint(equalToConstant: 0.74).isActive = true
    }
}

