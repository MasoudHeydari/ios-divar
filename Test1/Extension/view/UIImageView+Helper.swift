//
//  UIImageView+Helper.swift
//  Test1
//
//  Created by Masoud Heydari on 10/18/18.
//  Copyright © 2018 Masoud Heydari. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

extension UIImageView {
    public func setImageByURL(url: String, method: HTTPMethod) {
        if Utils.checkInternetConnection() {
            Alamofire.request(url, method: method).responseImage { response in
                if let image = response.result.value {
                    self.image = image
                }else {
                    print("cannot load image, there is a problem ... ")
                }
            }        } else {
            print("there is no internet connection, check your mobile data or wi-fi connection.")
        }
    }
    
    public func setImageByURL(url: String) {
        if Utils.checkInternetConnection() {
            Alamofire.request(url, method: .get).responseImage { response in
                if let image = response.result.value {
                    self.image = image
                }else {
                    print("cannot load image, there is a problem ... ")
                }
            }
        } else {
            print("there is no internet connection, check your mobile data or wi-fi connection.")
        }
    }
}
