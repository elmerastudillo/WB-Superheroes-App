//
//  ServiceWrapper.swift
//  Superheroes
//
//  Created by Elmer Astudillo on 6/20/19.
//  Copyright © 2019 Elmer Astudillo. All rights reserved.
//

import Foundation

import Foundation
import UIKit
import Alamofire

enum Router {
    case search(nameString: String)
    
    func path() -> String{
        switch self {
        case let .search(nameString):
            return "https://superheroapi.com/api/\(Constants.accessToken)/search/\(nameString)"
        }
    }
}

class NetworkingLayer: NSObject {
    // Get Method
    class func requestGETURL(_ router: Router, success:@escaping (Data) -> Void, failure:@escaping (Error) -> Void) {
        
        Alamofire.request(router.path()).responseJSON { (responseObject) -> Void in
            if responseObject.result.isSuccess {
                if let resJson = responseObject.data {
                    success(resJson)
                }
            }
            if responseObject.result.isFailure {
                let error : Error = responseObject.result.error!
                failure(error)
            }
        }
    }
}
