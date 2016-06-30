//
//  City.swift
//  TakeFods
//
//  Created by Tan Vu on 6/8/16.
//  Copyright © 2016 DevHack. All rights reserved.
//

import Realm
import RealmSwift
import ObjectMapper
import SwiftyJSON
import CoreLocation

class City: Object, Mappable {
  dynamic var id = 0
  dynamic var name = ""
  dynamic var state = ""
  dynamic var lastFetch = defaultDate

  required init() {
    super.init()
  }

  required convenience init?(_ map: Map) {
    self.init()
  }

  required init(value: AnyObject, schema: RLMSchema) {
    super.init(value: value, schema: schema)
  }

  required init(realm: RLMRealm, schema: RLMObjectSchema) {
    super.init(realm: realm, schema: schema)
  }

  convenience init(city: City) {
    self.init()
    self.id = city.id
    self.name = city.name
    self.state = city.state
  }

  override static func primaryKey() -> String? {
    return "id"
  }

  func mapping(map: Map) {
    id <- map["Id"]
    name <- map["Name"]
    state <- map["State"]
  }
}
