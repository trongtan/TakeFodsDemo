//
//  SignInSpec.swift
//  TakeFods
//
//  Created by Tan Vu on 6/8/16.
//  Copyright © 2016 DevHack. All rights reserved.
//

@testable import TakeFods
import Quick
import Nimble
import Mockingjay

class SignInSpec: BaseUISpec {
  override func spec() {
    super.spec()

    let sessionsMatcher = http(.POST, uri: apiPath + "/auth")
    func executeSignInStepsWithEmail(email: String, password: String) {
      self.tester().clearTextFromAndThenEnterText(email, intoViewWithAccessibilityLabel: "Sign In: Email Text Field")
      self.tester().clearTextFromAndThenEnterText(password, intoViewWithAccessibilityLabel: "Sign In: Password Text Field")
      self.tester().tapViewWithAccessibilityLabel("Sign In: Sign In Button")
    }

    describe("successfully") {
      beforeEach {
        self.stub(sessionsMatcher, builder: self.buildResponseWithContentsOfFile("user", statusCode: .OK))
        executeSignInStepsWithEmail("test@email.com", password: "123123")
      }

      it("redirects to home screen") {
        self.waitForHomeScreen()
      }
    }

    describe("unsuccessfully") {
      context("invalid user inputs") {
        context("invalid email format") {
          beforeEach {
            executeSignInStepsWithEmail("test.email.com", password: "123123")
          }

          it("displays error") {
            self.tester().waitForViewWithAccessibilityLabel("Must be a valid email address")
          }
        }

        context("empty password") {
          beforeEach {
            executeSignInStepsWithEmail("test@email.com", password: "")
          }

          it("displays error") {
            self.tester().waitForViewWithAccessibilityLabel("This field is required")
          }
        }
      }

      context("error response from server") {
        beforeEach {
          self.stub(sessionsMatcher, builder: self.buildResponseWithContentsOfFile("error", statusCode: .Unauthorized))
          executeSignInStepsWithEmail("test@email.com", password: "123123")
        }

        it("displays error response from server") {
          self.displaysError()
        }
      }
    }
  }
}
