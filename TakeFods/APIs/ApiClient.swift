//
//  ApiClient.swift
//  TakeFods
//
//  Created by Tan Vu on 6/8/16.
//  Copyright © 2016 DevHack. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ApiClient {
  static let sharedInstance = ApiClient()
  private let manager = Alamofire.Manager.sharedInstance

  private init() { }

  func request(URLRequest: URLRequestConvertible, completion: ((JSON?, NSError?) -> Void)) {
    UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    manager.request(URLRequest)
      .validate()
      .responseSwiftyJSON { response in
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        switch response.result {
        case .Success(let json): completion(json, nil)
        case .Failure(let error): completion(nil, error)
        }
    }
  }
}
