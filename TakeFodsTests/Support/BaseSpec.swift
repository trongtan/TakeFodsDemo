//
//  BaseSpec.swift
//  TakeFods
//
//  Created by Tan Vu on 6/8/16.
//  Copyright © 2016 DevHack. All rights reserved.
//

@testable import TakeFods
import Quick
import Nimble
import Mockingjay
import RealmSwift

class BaseSpec: QuickSpec {
  override func setUp() {
    super.setUp()
    NSUserDefaults.standardUserDefaults().clean()
    Realm.Configuration.defaultConfiguration.inMemoryIdentifier = self.name
  }

  override func spec() {
    super.spec()

    beforeEach {
      UINavigationController.rootNavigationController()?.popViewControllerAnimated(true)
    }

    afterEach {
      User.currentUser()?.signOut()
    }
  }

  func buildResponseWithContentsOfFile(fileName: String?, statusCode: HTTPStatusCode) -> (NSURLRequest) -> Response {
    func builder(request:NSURLRequest) -> Response {
      let response = NSHTTPURLResponse(URL: request.URL!, statusCode: statusCode.rawValue, HTTPVersion: nil, headerFields: nil)!
      if let fileName = fileName {
        let path = NSBundle(forClass: self.dynamicType).pathForResource(fileName, ofType: "json")
        let data = NSData(contentsOfFile: path ?? "")
        return .Success(response, data)
      } else {
        return .Success(response, nil)
      }
    }
    return builder
  }
}
