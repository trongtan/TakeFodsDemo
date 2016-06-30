//
//  CityBuilder.swift
//  TakeFods
//
//  Created by Tan Vu on 6/8/16.
//  Copyright © 2016 DevHack. All rights reserved.
//

@testable import TakeFods

extension City {
  convenience init(id: Int, name: String = faker.address.city()) {
    self.init()
    self.id = id
    self.name = name
  }
}

