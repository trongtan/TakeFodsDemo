//
//  UINavigationController+Extension.swift
//  TakeFods
//
//  Created by Tan Vu on 6/8/16.
//  Copyright © 2016 DevHack. All rights reserved.
//

import UIKit

extension UINavigationController {
  class func rootNavigationController() -> UINavigationController? {
    return (UIApplication.sharedApplication().delegate as? AppDelegate)?.window?.rootViewController as? UINavigationController
  }
}
