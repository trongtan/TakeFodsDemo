//
//  Validator+Extension.swift
//  TakeFods
//
//  Created by Tan Vu on 6/8/16.
//  Copyright © 2016 DevHack. All rights reserved.
//

import SwiftValidator

extension Validator {
  class func defaultValidator() -> Validator {
    let validator = Validator()
    validator.styleTransformers(success: { validationRule in
      validationRule.errorLabel?.hidden = true
      validationRule.errorLabel?.text = ""
      }, error: { validationError in
        validationError.errorLabel?.hidden = false
        validationError.errorLabel?.text = validationError.errorMessage
    })
    return validator
  }
}
