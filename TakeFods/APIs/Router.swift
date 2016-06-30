//
//  Router.swift
//  TakeFods
//
//  Created by Tan Vu on 6/8/16.
//  Copyright © 2016 DevHack. All rights reserved.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible {
  case SignIn([String: AnyObject]?)

  var URLRequest: NSMutableURLRequest {
    let results: (String, String, [String: AnyObject]?) = {
      switch self {
      case SignIn(let parameters):
        return ("POST", "/auth", parameters)
      }
    }()

    let (method, path, parameters) = results

    let URL = NSURL(string: apiBaseUrl)!
    let URLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(path))
    URLRequest.HTTPMethod = method

    // set authentication headers
    URLRequest.setHeaders(AuthenticationService.sharedInstance.headers)

    var encoding = Alamofire.ParameterEncoding.JSON
    if method == "GET" {
      encoding = Alamofire.ParameterEncoding.URL
    }

    return encoding.encode(URLRequest, parameters: parameters).0
  }
}

