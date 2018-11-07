//
//  AdvertisingCell.swift
//  Test1
//
//  Created by Masoud Heydari on 10/13/18.
//  Copyright © 2018 Masoud Heydari. All rights reserved.
//

import UIKit

class AdvertisingCell: BaseCell {
    
    var advertisingModel: AdvertisingModel? {
        didSet {
            if let advertisingModel = self.advertisingModel {
                self.titleLabel.text = advertisingModel.title
                self.locationLabel.text = advertisingModel.location
                self.priceLabel.text = "\(String(describing: advertisingModel.date)) , \(String(describing: advertisingModel.price))"
            }   
        }
    }
    
    let image: UIImageView = {
        let image = UIImageView()
        let img = UIImage(named: Const.Image.tempImage)
        image.backgroundColor = UIColor.Gray.light1
        image.image = img?.imageWithInset(insets: UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 20))
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let titleLabel: UITextView = {
        let title = UITextView()
        title.textAlignment = .right
        title.isUserInteractionEnabled = false
        title.textContainerInset = UIEdgeInsets(top: 6, left: 0, bottom: 0, right: 0)
        title.font = UIFont.systemFont(ofSize: 17)
        title.isEditable = false
        title.isScrollEnabled = false
        title.isSelectable = false
        title.text = Const.Cells.AllAdvertising.tempAdvertisingTitle
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    let locationLabel: UILabel = {
        let location = UILabel()
        location.translatesAutoresizingMaskIntoConstraints = false
        location.text = Const.Cells.AllAdvertising.fakeLocationAndTime
        location.textAlignment = .right
        location.textColor = UIColor.Gray.textGrayLight
        location.font = UIFont.systemFont(ofSize: 13)
        return location
    }()
    
    let priceLabel: UILabel = {
        let price = UILabel()
        price.font = UIFont.systemFont(ofSize: 15)
        price.textColor = UIColor.Gray.textGrayDark
        price.textAlignment = .right
        price.translatesAutoresizingMaskIntoConstraints = false
        price.text = Const.Cells.AllAdvertising.fakePrice
        return price
    }()
    
    override public func setupView() {
        super.setupView()
        
        addSubview(image)
        addSubview(titleLabel)
        addSubview(priceLabel)
        addSubview(locationLabel)

        image.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 4).isActive = true
        image.topAnchor.constraint(equalTo: self.topAnchor, constant: 4).isActive = true
        image.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4).isActive = true
        image.widthAnchor.constraint(equalToConstant: frame.height).isActive = true
        
        titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: self.image.rightAnchor, constant: 4).isActive = true
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 4).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: frame.height / 2).isActive = true
        
        priceLabel.rightAnchor.constraint(equalTo: self.titleLabel.rightAnchor).isActive = true
        priceLabel.leftAnchor.constraint(equalTo: self.image.rightAnchor).isActive = true
        priceLabel.bottomAnchor.constraint(equalTo: self.image.bottomAnchor, constant: -4).isActive = true
        
        locationLabel.rightAnchor.constraint(equalTo: self.titleLabel.rightAnchor).isActive = true
        locationLabel.leftAnchor.constraint(equalTo: self.image.rightAnchor).isActive = true
        locationLabel.bottomAnchor.constraint(equalTo: self.priceLabel.topAnchor, constant: -8).isActive = true
    }
}
