//
//  UserBuilder.swift
//  TakeFods
//
//  Created by Tan Vu on 6/8/16.
//  Copyright © 2016 DevHack. All rights reserved.
//

@testable import TakeFods
import Foundation
import Fakery
let faker = Faker()

extension User {
  convenience init(id: Int, email: String, workAddress: String, city: City) {
    self.init()
    self.id = id
    self.email = email
    self.firstName = faker.name.firstName()
    self.lastName = faker.name.lastName()
    self.workAddress = workAddress
    self.startDate = NSDate(timeIntervalSinceNow: -86400)
    self.nextPayment = NSDate(timeIntervalSinceNow: 86400)
    self.city = city
  }
}

class UserBuilder {
  private var id = 1
  private var email = faker.internet.email()
  private var workAddress = faker.address.streetName()
  private var city = City(id: 1, name: faker.address.city())

  func buildObject() -> User {
    return User(id: id, email: email, workAddress: workAddress, city: city)
  }
}
