//
//  UserSpec.swift
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

class UserSpec: BaseSpec {
  override func spec() {
    super.spec()

    var user: User!
    let pickupTime = NSDate()
    var expectedError: NSError?

    func makeSignInRequest() {
      user.requestSignInWithCompletion { error in
        expectedError = error
      }
    }

    beforeEach {
      user = UserBuilder().buildObject()
      user.save()
      expectedError = nil
    }

    describe(".currentUser") {
      context("user have not signed-in yet") {
        beforeEach {
          user.signOut()
        }

        it("returns nil") {
          expect(User.currentUser()).to(beNil())
        }
      }

      context("user is already signed-in") {
        beforeEach {
          user.signIn()
        }

        it("returns signed-in user") {
          expect(User.currentUser(reload: true)).to(equal(user))
        }
      }
    }

    describe("#signIn") {
      it("saves user to local database") {
        user.signIn()

        expect(User.currentUser()).toNot(beNil())
        let currentUser = User.currentUser()!
        expect(currentUser.name).to(equal(user.name))
        expect(currentUser.email).to(equal(user.email))
        expect(currentUser.workAddress).to(equal(user.workAddress))
      }
    }

    describe("#signOut") {
      beforeEach {
        user.signIn()
      }

      it("removes current user") {
        user.signOut()

        expect(User.currentUser()).to(beNil())
      }
    }

    describe("#requestSignInWithCompletion") {
      let sessionsMatcher = http(.POST, uri: apiPath + "/auth")

      context("successfully") {
        let expectedEmail = "test@email.com"
        let expectedCity = "Da Nang"

        beforeEach {
          expectedError = NSError(domain: "", code: 1, userInfo: nil)
          self.stub(sessionsMatcher, builder: self.buildResponseWithContentsOfFile("user", statusCode: .OK))
        }

        it("stores current user to local data") {
          makeSignInRequest()

          expect(expectedError).toEventually(beNil())
          expect(User.currentUser()?.email).to(equal(expectedEmail))
          expect(User.currentUser()?.city?.name).to(equal(expectedCity))
        }
      }

      context("unsuccessfully") {
        beforeEach {
          self.stub(sessionsMatcher, builder: self.buildResponseWithContentsOfFile("error", statusCode: .Unauthorized))
        }

        it("calls completion closure with NSError") {
          makeSignInRequest()

          expect(expectedError).toEventuallyNot(beNil())
        }
      }
    }
  }
}
