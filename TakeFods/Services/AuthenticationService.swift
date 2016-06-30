//
//  AuthenticationService.swift
//  TakeFods
//
//  Created by Tan Vu on 6/8/16.
//  Copyright © 2016 DevHack. All rights reserved.
//

import Foundation
import SwiftSpinner
import Async

class AuthenticationService {
  static let sharedInstance = AuthenticationService()
  var headers: [String: String] {
    get {
      if let user = User.fetchCurrentUser() {
        return [
          "Authorization": "Bearer \(user.token)"
        ]
      }
      return [:]
    }
  }

  private init() {
    NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(unauthorized(_:)), name: TFNotifitcation.Unauthorized.rawValue, object: nil)
  }

  @objc private func unauthorized(notification: NSNotification) {
    Async.main {
      if let user = User.currentUser(reload: true) where !user.reauthenticating {
        SwiftSpinner.show("Re-Authenticating...")
        user.save { _ in
          user.reauthenticating = true
        }

        user.requestSignInWithCompletion { error in
          let completeClosure: (() -> Void) = {
            SwiftSpinner.hide()
            user.save { _ in
              user.reauthenticating = false
            }
          }

          if let _ = error {
            SwiftSpinner.show("Authentication failed!", animated: false)
            Async.main(after: 0.5) {
              UINavigationController.rootNavigationController()
              completeClosure()
              user.signOut()
            }
          } else {
            completeClosure()
            NSNotificationCenter.defaultCenter().postNotificationName(TFNotifitcation.ReloadCurrentUser.rawValue, object: nil)
          }
        }
      }
    }
  }
}
