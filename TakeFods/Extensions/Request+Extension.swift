//
//  Request+Extension.swift
//  TakeFods
//
//  Created by Tan Vu on 6/8/16.
//  Copyright © 2016 DevHack. All rights reserved.
//

import Alamofire
import SwiftyJSON

extension Request {
  public static func SwiftyJSONResponseSerializer(options options: NSJSONReadingOptions = .AllowFragments) -> ResponseSerializer<JSON, NSError> {
    return ResponseSerializer { request, response, data, error in
      if response?.statusCode == HTTPStatusCode.Unauthorized.rawValue {
        NSNotificationCenter.defaultCenter().postNotificationName(TFNotifitcation.Unauthorized.rawValue, object: nil)
      }

      if let data = data where data.length > 0 {
        let json = JSON(data: data)
        if json.rawValue is NSNull {
          return .Failure(NSError(domain: Error.Domain, code: response!.statusCode, userInfo: [NSLocalizedDescriptionKey: "JSON is invalid"]))
        } else if let responseError = json["error"].string {
          let error = NSError(domain: Error.Domain, code: response!.statusCode, userInfo: [NSLocalizedDescriptionKey: responseError])
          return .Failure(error)
        } else {
          return .Success(json)
        }
      } else if let error = error {
        return .Failure(error)
      } else {
        return .Success(nil)
      }
    }
  }

  public func responseSwiftyJSON(options options: NSJSONReadingOptions = .AllowFragments, completionHandler: Response<JSON, NSError> -> Void) -> Self {
    return response(
      responseSerializer: Request.SwiftyJSONResponseSerializer(options: options),
      completionHandler: completionHandler
    )
  }
}
