//
//  Object+Extension.swift
//  TakeFods
//
//  Created by Tan Vu on 6/8/16.
//  Copyright © 2016 DevHack. All rights reserved.
//

import RealmSwift

extension Object {
  class func find<T: Object>(key: AnyObject) -> T? {
    return try! Realm().objectForPrimaryKey(T.self, key: key)
  }

  func save(closure: ((Realm) -> Void)? = nil) {
    let currentRealm: Realm = {
      if let realm = realm {
        return realm
      }
      return try! Realm()
    }()

    currentRealm.writeTransaction {
      closure?(currentRealm)
      currentRealm.add(self, update: true)
    }
  }
}

