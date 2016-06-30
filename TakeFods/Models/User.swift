//
//  User.swift
//  TakeFods
//
//  Created by Tan Vu on 6/8/16.
//  Copyright © 2016 DevHack. All rights reserved.
//

import Realm
import RealmSwift
import ObjectMapper
import SwiftyJSON

class User: Object, Mappable {
  dynamic var id = 0
  dynamic var firstName = ""
  dynamic var lastName = ""
  dynamic var email = ""
  dynamic var password = ""
  dynamic var token = ""
  dynamic var reauthenticating = false
  dynamic var workAddress = ""
  dynamic var nextPayment = defaultDate
  dynamic var startDate = defaultDate
  dynamic var city: City?

  var name: String {
    return "\(firstName) \(lastName)"
  }

  required init() {
    super.init()
  }

  override init(value: AnyObject) {
    super.init(value: value)
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

  override static func primaryKey() -> String? {
    return "id"
  }

  func mapping(map: Map) {
    token <- map["Token"]
    id <- map["User.Id"]
    firstName <- map["User.FirstName"]
    lastName <- map["User.LastName"]
    email <- map["User.Email"]
    workAddress <- map["User.WorkAddress"]
    startDate <- (map["User.StartDate"], DateFormatterTransform(dateFormatter: TFDateFormatter.serverResponseFormatter))
    city <- map["User.City"]
  }

  // MARK: Authentication
  private static var _currentUser: User?

  // fetch current user in calling thread
  class func fetchCurrentUser() -> User? {
    if let currentUserID = UserDefaultsKey.CurrentUserID.getValue() as? Int {
      return User.find(currentUserID)
    }
    return nil
  }

  // rule: only accessible via main thread
  class func currentUser(reload reload: Bool = false) -> User? {
    if reload || _currentUser == nil {
      _currentUser = fetchCurrentUser()
    }
    return _currentUser
  }

  func signIn() {
    save()
    UserDefaultsKey.CurrentUserID.setValue(id)
    User._currentUser = self
  }

  func signOut() {
    User._currentUser = nil
    NSUserDefaults.standardUserDefaults().clean()
  }

  // MARK: APIs
  func requestSignInWithCompletion(completion: DefaultAPIRequestCompletion) {
    let parameters = [
      "Username": email,
      "Password": password,
      ]

    ApiClient.sharedInstance.request(Router.SignIn(parameters)) { json, error in
      if error == nil {
        let user = Mapper<User>().map(json?.rawValue)
        // save user input password for later re-authenticate
        user?.password = self.password
        user?.signIn()
      }
      completion(error)
    }
  }
}

