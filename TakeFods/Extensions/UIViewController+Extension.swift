//
//  UIViewController+Extension.swift
//  TakeFods
//
//  Created by Tan Vu on 6/8/16.
//  Copyright © 2016 DevHack. All rights reserved.
//

import UIKit

extension UIViewController {
  func presentErrorAlertWithError(error: String) {
    presentAlertWithTitle("Error", message: error)
  }

  func presentAlertWithTitle(title: String, message: String) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
    let cancelAction = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
    alertController.addAction(cancelAction)
    presentViewController(alertController, animated: true, completion: nil)
  }
}