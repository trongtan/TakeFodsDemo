//
//  Realm+Extension.swift
//  TakeFods
//
//  Created by Tan Vu on 6/8/16.
//  Copyright © 2016 DevHack. All rights reserved.
//

import RealmSwift

extension Realm {
  func writeTransaction(transaction: (() -> Void)) {
    if inWriteTransaction {
      transaction()
    } else {
      try! write {
        transaction()
      }
    }
  }

  class func writeTransaction(transaction: ((Realm) -> Void)) {
    let realm = try! Realm()
    realm.writeTransaction {
      transaction(realm)
    }
  }
}
