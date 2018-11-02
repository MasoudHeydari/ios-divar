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
    var parameters: [String: AnyObject]?
    var encoding: ParameterEncoding
    var headers: [String: String]?
    
    init() {
        method = .get
        path = ""
        parameters = nil
        encoding = JSONEncoding() as ParameterEncoding
        headers = ["Content-Type": "application/json",
                   "X-Requested-With": "XMLHttpRequest",
                   "Cache-Control": "no-cache"]
    }
}

class BaseService: NSObject {
    
    func callWebServiceAlamofire(_ alamoReq: AlamofireRequestModal, success: @escaping ((_ responseObject: AnyObject?) -> Void), failure: @escaping ((_ error: NSError?) -> Void)) {
        
        // Create alamofire request
        // "alamoReq" is overridden in services, which will create a request here
        let req = Alamofire.request(alamoReq.path, method: alamoReq.method, parameters: alamoReq.parameters, encoding: alamoReq.encoding, headers: alamoReq.headers)
        
        // Call response handler method of alamofire
        req.validate(statusCode: 200..<600).responseJSON(completionHandler: { response in
            let statusCode = response.response?.statusCode
            
            switch response.result {
            case .success(let data):
                
                if statusCode == 200 {
                    print( "\n Success: \(response)")
                    success(data as AnyObject?)
                    
                } else if statusCode == 403 {
                    // Access token expire
                    self.requestForGetNewAccessToken(alaomReq: alamoReq, success: success, failure: failure as! ((Error?) -> Void))
                    
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
    
    func getAccessToken() -> String {
        if let accessToken =  UserDefaults.standard.value(forKey: "AccessToken") as? String {
            return "Bearer " + accessToken
        } else {
            return ""
        }
    }
    
    // MARK: - API CALL
    func requestForGetNewAccessToken(alaomReq: AlamofireRequestModal, success: @escaping ((_ responseObject: AnyObject?) -> Void), failure: @escaping ((_ error: Error?) -> Void) ) {
        
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
