//
//  APIService.swift
//  Test1
//
//  Created by Masoud Heydari on 10/29/18.
//  Copyright © 2018 Masoud Heydari. All rights reserved.
//

import Foundation

let GET_USER_PROFILE_METHOD = "user/profile"

struct BaseURL {
    // Local Server
    static let urlString: String = "http://192.168.10.236: 8084/"
    // QAT Server
    // static let urlString: String = "http://192.171.286.74: 8080/"
    
    static let staging: String = BaseURL.urlString + "api/v1/"
}

class APIService: BaseService {
    
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
    
}
