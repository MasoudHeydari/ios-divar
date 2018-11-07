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
    
    static func getRandomNumBetween(_ from: UInt32, to: UInt32) -> UInt32{
        let lower : UInt32 = from
        let upper : UInt32 = to
        let randomNumber = arc4random_uniform(upper - lower) + lower
        print(randomNumber)
        return randomNumber
    }
    
    static func getRandomCGFloat() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
    
    static func getCurrentDate() -> String {
        let formatter = DateFormatter()
        // initially set the format based on your datepicker date / server String
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let myString = formatter.string(from: Date()) // string purpose I add here
        // convert your string to date
//        let yourDate = formatter.date(from: myString)
//        //then again set the date format whhich type of output you need
//        formatter.dateFormat = "dd-MMM-yyyy"
//        // again convert your date to string
//        let myStringafd = formatter.string(from: yourDate!)
        
        print("current date: \(myString)")
        return myString
    }
    
    static func getCurrentTiem(){
        
    }
    
    static func getCurrentDateAndTime() {
        
    }
}
