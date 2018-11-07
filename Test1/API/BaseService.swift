//
//  BaseService.swift
//  Test1
//
//  Created by Masoud Heydari on 10/29/18.
//  Copyright © 2018 Masoud Heydari. All rights reserved.
//

import Foundation
import Alamofire

struct AlamofireRequestModal {
    var method: Alamofire.HTTPMethod
    var path: String
    var parameters: [String: Any]?
    var encoding: ParameterEncoding
    var headers: [String: String]?
    
    init() {
        method = .get
        path = ""
        parameters = nil
        encoding = JSONEncoding() as ParameterEncoding
        headers = [:]
    }
}

class BaseService: NSObject {
        
    internal func callWebServiceAlamofire(_ alamofireRequest: AlamofireRequestModal, success: @escaping ((_ responseObject: AnyObject?) -> Void), failure: @escaping ((_ error: NSError?) -> Void)) {
        
        // Create alamofire request
        // "alamofireRequest" is overridden in services, which will create a request here
        let req = Alamofire.request(alamofireRequest.path, method: alamofireRequest.method, parameters: alamofireRequest.parameters, encoding: alamofireRequest.encoding, headers: alamofireRequest.headers)
        
        // Call response handler method of alamofire
        req.validate(statusCode: 200..<600).responseJSON(completionHandler: { response in
            let statusCode = response.response?.statusCode
            
            switch response.result {
            case .success(let data):
                
                if statusCode == 200 {
                    //print( "\n Success: \(response)")
                    success(data as AnyObject?)
                    
                } else if statusCode == 403 {
                    // Access token expired
                    self.requestForGetNewAccessToken(alamofireRequest: alamofireRequest, success: success, failure: failure as! ((Error?) -> Void))
                    
                } else {
                    let errorDict: [String: Any] = ((data as? NSDictionary)! as? [String: Any])!
                   print( "\n \(errorDict)")
                }
            case .failure(let error):
                print("\n Failure: \(error.localizedDescription)")
                failure(error as NSError?)
            }
        })
    }
    
}

extension BaseService {
    
    internal func getAccessToken() -> String {
        if let accessToken =  KeychainWrapper.standard.string(forKey: Const.API.accessTokenKey) {
            return Const.API.bearer + accessToken
        } else {
            return Const.empty
        }
    }
    
    // MARK: - API CALL
    internal func requestForGetNewAccessToken(alamofireRequest: AlamofireRequestModal, success: @escaping ((_ responseObject: AnyObject?) -> Void), failure: @escaping ((_ error: Error?) -> Void) ) {
        
//        UserModal().getAccessToken(success: { (responseObj) in
//            if let accessToken = responseObj?.value(forKey: "accessToken") {
//                UserDefaults.standard.set(accessToken, forKey: UserDefault.userAccessToken)
//            }
//            
//            // override existing alaomReq (updating token in header)
//            var request: AlamofireRequestModal = alaomReq
//            request.headers = ["Content-Type": "application/json",
//                               "X-Requested-With": "XMLHttpRequest",
//                               "Cache-Control": "no-cache",
//                               "X-Authorization": self.getAccessToken()]
//            
//            self.callWebServiceAlamofire(request, success: success, failure: failure)
//            
//        }, failure: { (_) in
//            self.requestForGetNewAccessToken(alaomReq: alaomReq, success: success, failure: failure)
//        })
    }
    
}
