//
//  Constants.swift
//  TakeFods
//
//  Created by Tan Vu on 6/8/16.
//  Copyright © 2016 DevHack. All rights reserved.
//

import Foundation

let apiProtocol = "http"
let apiHost = "takefods"
let apiPath = "/api"
let takeFodsUrl = apiProtocol + "://" + apiHost
let apiBaseUrl = takeFodsUrl + apiPath

let defaultDate = NSDate(timeIntervalSince1970: 0)

enum TFNotifitcation: String {
  case Unauthorized = "TFNotifitcation.Unauthorized"
  case ReloadCurrentUser = "TFNotifitcation.ReloadCurrentUser"
}

enum UserDefaultsKey: String {
  case CurrentUserID = "CurrentUserID"

  func setValue(newValue: AnyObject) {
    NSUserDefaults.standardUserDefaults().setObject(newValue, forKey: rawValue)
    NSUserDefaults.standardUserDefaults().synchronize()
  }

  func getValue() -> AnyObject? {
    return NSUserDefaults.standardUserDefaults().objectForKey(rawValue)
  }
}

typealias DefaultAPIRequestCompletion = ((NSError?) -> Void)
