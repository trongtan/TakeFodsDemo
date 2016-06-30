//
//  TFDateFormatter.swift
//  TakeFods
//
//  Created by Tan Vu on 6/8/16.
//  Copyright © 2016 DevHack. All rights reserved.
//

import Foundation

class TFDateFormatter: NSDateFormatter {
  static let timeFormatter = TFDateFormatter(dateFormat: "HH:mm")
  static let dateFormatter = TFDateFormatter(dateFormat: "MMM dd, yyyy")
  static let serverResponseFormatter = TFDateFormatter(dateFormat: "yyyy-MM-dd'T'HH:mm:ss'.'SSSZZZZZ")

  convenience init(dateFormat: String) {
    self.init()
    self.dateFormat = dateFormat
  }
}
