//
//  BaseUISpec.swift
//  TakeFods
//
//  Created by Tan Vu on 6/8/16.
//  Copyright © 2016 DevHack. All rights reserved.
//

@testable import TakeFods
import Quick
import Nimble
import Mockingjay
import KIF

class BaseUISpec: BaseSpec {
  private var getReservationStub: Stub!
  var kitchenStatusStub: Stub!

  override func setUp() {
    super.setUp()
    KIFTestCase.setUp()
  }

  override func tearDown() {
    super.tearDown()
    KIFTestCase.tearDown()
  }

  override func spec() {
    super.spec()

    beforeEach {
      self.requiredStubRequests()
      self.tester().waitForAnimationsToFinish()
    }

    afterEach {
      self.tester().waitForAnimationsToFinish()
    }
  }

  // MARK: Misc
  private func requiredStubRequests() {
  }

  func waitForHomeScreen() {
    self.tester().waitForAnimationsToFinish()
    self.tester().waitForViewWithAccessibilityLabel("Home")
  }

  func displayAlertWithMessage(message: String) {
    self.tester().waitForViewWithAccessibilityLabel(message)
    self.tester().tapViewWithAccessibilityLabel("OK")
    self.tester().waitForAbsenceOfViewWithAccessibilityLabel(message)
  }

  func displaysError() {
    displayAlertWithMessage("error message")
  }
}
