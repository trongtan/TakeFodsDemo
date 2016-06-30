//
//  NSMutableURLRequest+Extension.swift
//  TakeFods
//
//  Created by Tan Vu on 6/8/16.
//  Copyright © 2016 DevHack. All rights reserved.
//

import Foundation

extension NSMutableURLRequest {
  func setHeaders(headers: [String: String]) {
    for (key, value) in headers {
      setValue(value, forHTTPHeaderField: key)
    }
  }
}
