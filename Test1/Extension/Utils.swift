//
//  Utils.swift
//  Test1
//
//  Created by Masoud Heydari on 10/16/18.
//  Copyright © 2018 Masoud Heydari. All rights reserved.
//

import UIKit
import Alamofire

class Utils {
    
    class func callToPhoneNumber(phoneNumber: String){
        if let url = URL(string: "tel://\(phoneNumber)"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                // openURL was deprecated in ios 10
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    class func checkInternetConnection() -> Bool {
        let isConnected = NetworkReachabilityManager()!.isReachable
        print("is connected to internet : \(isConnected)")
        return isConnected
    }
}
