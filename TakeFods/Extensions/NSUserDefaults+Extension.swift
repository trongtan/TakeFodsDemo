//
//  NSUserDefaults+Extension.swift
//  TakeFods
//
//  Created by Tan Vu on 6/8/16.
//  Copyright © 2016 DevHack. All rights reserved.
//

import Foundation

extension NSUserDefaults {
  func clean() {
    if let bundleIdentifier = NSBundle.mainBundle().bundleIdentifier {
      removePersistentDomainForName(bundleIdentifier)
    }
  }
}
