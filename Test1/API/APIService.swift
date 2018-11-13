//
//  APIService.swift
//  Test1
//
//  Created by Masoud Heydari on 10/29/18.
//  Copyright © 2018 Masoud Heydari. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

let GET_USER_PROFILE_METHOD = "user/profile"

struct BaseURL {
    // Local Server
    static let urlString: String = "http://192.168.10.236: 8084/"
    // QAT Server
    // static let urlString: String = "http://192.171.286.74: 8080/"
    static let staging: String = BaseURL.urlString + "api/v1/"
}

class APIService: BaseService {
    
    /// The shared instance to define the singleton.
    static let shared = APIService()
    
    // no one can create any instance of this object.
    // added by Masoud Heydari.   10 NOV 2018   09:57 AM
    private override init() {
    }
    
    func getUserProfile(success: @escaping ((_ responseObject: Any?) -> Void), failure: @escaping ((_ error: Error?) -> Void)) {
        var request: AlamofireRequestModal = AlamofireRequestModal()
        request.method = .get
        request.path = BaseURL.staging + GET_USER_PROFILE_METHOD
        request.headers = ["Content-Type": "application/json",
                           "X-Requested-With": "XMLHttpRequest",
                           "Cache-Control": "no-cache",
                           "X-Authorization": getAccessToken()]
        
        self.callWebServiceAlamofire(request, success: success, failure: failure)
    }
    
    func loginUser(userName: String, password: String, completion: @escaping (_ response: Any?) -> Void){
        let param = [
            "email" : userName,
            "password" : password
        ]
        
        var request: AlamofireRequestModal = AlamofireRequestModal()
        request.method = .post
        request.path = Const.URL.loginEndPoint
        request.parameters = param 
        request.encoding = URLEncoding.httpBody
        request.headers = nil
        
        self.callWebServiceAlamofire(request, success: { (response) in
            if let response = response {
                let json = JSON(response)
                completion(json)
                if let userId = json["user_id"].int, let fullName = json["fullName"].string {
                    print("userId is: \(userId)")
                    
                    // remonve previous user information from keychain
                    KeychainWrapper.standard.removeObject(forKey: Const.API.userId)
                    KeychainWrapper.standard.removeObject(forKey: Const.API.fullName)
                    
                    // add user information to keychain
                    KeychainWrapper.standard.set(userId, forKey: Const.API.userId)
                    KeychainWrapper.standard.set(fullName, forKey: Const.API.fullName)
                    KeychainWrapper.standard.set(true, forKey: Const.API.isLoggedIn)
                }
            }
        }) { (error) in
            completion(nil)
            print(error?.localizedDescription as Any)
        }
        
        
        
    }
    
    func registerNewUser(fullName: String, userName: String, password: String, completion: @escaping (_ response: Any?) -> Void){
        let param = [
            "fullName" : fullName,
            "email" : userName,
            "password" : password
        ]
        
        var request: AlamofireRequestModal = AlamofireRequestModal()
        request.method = .post
        request.path = Const.URL.registerEndPoint
        request.parameters = param
        request.encoding = URLEncoding.httpBody
        request.headers = nil
        
        self.callWebServiceAlamofire(request, success: { (response) in
            if let response = response {
                let json = JSON(response)
                completion(json)
                if let userId = json["user_id"].int {
                    
                    // remonve previous user information from keychain
                    KeychainWrapper.standard.removeObject(forKey: Const.API.userId)
                    KeychainWrapper.standard.removeObject(forKey: Const.API.fullName)
                    
                    // add user information to keychain
                    KeychainWrapper.standard.set(userId, forKey: Const.API.userId)
                    KeychainWrapper.standard.set(fullName, forKey: Const.API.fullName)
                    KeychainWrapper.standard.set(true ,forKey: Const.API.isLoggedIn)
                }
            }
        }) { (error) in
            completion(nil)
            print(error?.localizedDescription as Any)
        }
    }
    
    func isLoggedIn() -> Bool {
        return KeychainWrapper.standard.bool(forKey: Const.API.isLoggedIn) ?? false
    }
    
    public func getAllAdvertisingsFromServer(completion: @escaping (_ done: Bool, _ advertisingList: [AdvertisingModel]?) -> Void) {
        var advertisingsList = [AdvertisingModel]()
        var request: AlamofireRequestModal = AlamofireRequestModal()
        request.method = .get
        request.encoding = URLEncoding.default
        request.headers = nil
        request.path = Const.URL.allAdvertisingsEndPoint
        request.parameters = [ : ]
        
        self.callWebServiceAlamofire(request, success: { (response) in
            // optional unwrapping 'response'
            if let response = response {
                let jsonArray = JSON(response)
                if let jsonArray = jsonArray.array {
                    for json in jsonArray {
                        let advertisin = AdvertisingModel(json: json)
                        advertisingsList.append(advertisin)
                    }
                    completion(true, advertisingsList)
                }
            } else {
                completion(false, nil)
                print("response for all advertising in null")
            }
            
        }) { (error) in
            completion(false, nil)
        }
    }
    
    public func registerNewAdvertising(newAdvertising: NewAdvertisingModel, completion: @escaping (_ done: Bool, _ response: String?) -> Void){
        var request: AlamofireRequestModal = AlamofireRequestModal()
        request.method = .post
        request.encoding = URLEncoding.httpBody
        request.headers = nil
        request.path = Const.URL.newAdvertisingEndPoint
        
        request.parameters = [
            "user_id" : KeychainWrapper.standard.integer(forKey: Const.API.userId)!,
            "title" : newAdvertising.title,
            "description" : newAdvertising.description,
            "price" : newAdvertising.price,
            "phoneNumber" : newAdvertising.phoneNumber,
            "location" : newAdvertising.location
        ]
        
        self.callWebServiceAlamofire(request, success: { (response) in
            // optional unwrapping 'response'
            if let response = response {
                let json = JSON(response)
                if let isSuccessful = json["isSuccessful"].bool {
                    if isSuccessful {
                        completion(isSuccessful, json["response"].string)
                    }
                }
                print(4)
            } else {
                print("response for all advertising in null")
            }
        }) { (error) in
            completion(false, nil)
            print(12342423748234)
            print(error?.localizedDescription ?? "there is an error while registering new advertising")
        }
    }
    
    public func getDetailsOfAdvertisingByUserId(advertisingId: UInt, userId: UInt, completion: @escaping (_ done: Bool, _ detailsOfAdvertising: DetailAdvertisingModel?) -> Void){
        
        var request = AlamofireRequestModal()
        request.method = .post
        request.path = Const.URL.singleAdvertisingByUserId
        request.encoding = URLEncoding.httpBody
        request.headers = nil
        request.parameters = [
            Const.API.advertisingId : advertisingId,
            Const.API.userId : userId
        ]
        
        self.callWebServiceAlamofire(request, success: { (serverResponse) in
            if let serverResponse = serverResponse {
                let jsonResponse = JSON(serverResponse)
                let detailsOfAdvertising = DetailAdvertisingModel()
                
                detailsOfAdvertising.title = jsonResponse["title"].string
                detailsOfAdvertising.description = jsonResponse["description"].string
                detailsOfAdvertising.price = jsonResponse["price"].string
                detailsOfAdvertising.phoneNumber = jsonResponse["phoneNumber"].string
                detailsOfAdvertising.date = jsonResponse["date"].string
                detailsOfAdvertising.location = jsonResponse["location"].string
                detailsOfAdvertising.isFavorite = Bool(jsonResponse["isLiked"].string ?? "false")
                
                completion(true, detailsOfAdvertising)
            }
        }) { (error) in
            completion(false, nil)
        }
        
    }
    
    public func getDetailsOfAdvertising(advertisingId: UInt, completion: @escaping (_ done: Bool, _ detailsOfAdvertising: DetailAdvertisingModel?) -> Void) {
        var request = AlamofireRequestModal()
        request.path = Const.URL.sigleAdvertising
        request.encoding = URLEncoding.httpBody
        request.method = .post
        request.headers = nil
        request.parameters = [
            Const.API.advertisingId : advertisingId
        ]
        
        self.callWebServiceAlamofire(request, success: { (serverResponse) in
            if let serverResponse = serverResponse {
                let jsonResponse = JSON(serverResponse)
                let detailsOfAdvertising = DetailAdvertisingModel()
                
                detailsOfAdvertising.title = jsonResponse["title"].string
                detailsOfAdvertising.description = jsonResponse["description"].string
                detailsOfAdvertising.price = jsonResponse["price"].string
                detailsOfAdvertising.phoneNumber = jsonResponse["phoneNumber"].string
                detailsOfAdvertising.date = jsonResponse["date"].string
                detailsOfAdvertising.location = jsonResponse["location"].string
                
                completion(true, detailsOfAdvertising)
            }
        }) { (error) in
            completion(false, nil)
        }
    }
    
    
    public func likeAdvertising(advertisingId: UInt, userId: UInt, completion: @escaping (_ done: Bool, _ response: String?) -> Void) {
        
        var request = AlamofireRequestModal()
        request.method = .post
        request.headers = nil
        request.encoding = URLEncoding.httpBody
        request.path = Const.URL.likeAdvertising
        request.parameters = [
            Const.API.userId : userId,
            Const.API.advertisingId : advertisingId
        ]
        
        self.callWebServiceAlamofire(request, success: { (serverResponse) in
            print(serverResponse as Any)
            if let serverResponse = serverResponse {
                let jsonResponse = JSON(serverResponse)
                completion(true, jsonResponse["response"].string)
            }
        }) { (error) in
            completion(false, nil)
        }
    }
    
}
