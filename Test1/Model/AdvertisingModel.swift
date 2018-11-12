//
//  AdvertisingModel.swift
//  Test1
//
//  Created by Masoud Heydari on 10/13/18.
//  Copyright © 2018 Masoud Heydari. All rights reserved.
//

import UIKit
import SwiftyJSON

class AdvertisingModel {
    var advertising_id: UInt
    var title: String
    var date: String
    var price: String
    var location: String
    
    init(json: JSON) {
        // MARK:- delete casting to UInt, if needed.
        // added by : Masoud Heydari     10 NOV 2018     9:10   AM
        self.advertising_id = UInt(json["advertising_id"].string ?? "0") ?? 0
        self.title = json["title"].string ?? Const.empty
        self.date = json["date"].string ?? Const.empty
        self.location = json["location"].string ?? Const.empty
        self.price = json["price"].string ?? Const.empty
        
    }
}

class DetailAdvertisingModel {
    var advertising_id: NSNumber?
    var imgURL: [String]?
    var isFavorite: Bool?
    var phoneNumber: String?
    var title: String?
    var date: String?
    var location: String?
    var price: String?
    var description: String?
    
}

class NewAdvertisingModel {
    var title: String
    var description: String
    var phoneNumber: String
    var location: String
    var price: String
    
    init(title: String, description: String, phoneNumber: String, location: String, price: String) {
        self.title = title
        self.description = description
        self.phoneNumber = phoneNumber
        self.location = location
        self.price = price
    }
}
