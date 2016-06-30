//
//  SignInViewController.swift
//  TakeFods
//
//  Created by Tan Vu on 6/8/16.
//  Copyright © 2016 DevHack. All rights reserved.
//

import UIKit
import SwiftValidator
import SwiftSpinner

class SignInViewController: UIViewController {
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var emailErrorLabel: UILabel!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var passwordErrorLabel: UILabel!
  @IBOutlet weak var submitButton: UIButton!

  private let validator = Validator.defaultValidator()
  private let newUser = User()
  private let signInToHomeSegueIdentifier = "signInToHomeSegueIdentifier"

  override func viewDidLoad() {
    super.viewDidLoad()
    addValidationRules()
    setUpNavigationBar()
    setUpSignInButton()
  }

  // MARK: Misc
  private func setUpNavigationBar() {
    navigationController?.setNavigationBarHidden(true, animated: false)
  }

  private func setUpSignInButton() {
    submitButton.setBackgroundImage(UIImage.fromColor(UIColor(white: 1, alpha: 0.3)), forState: .Normal)
    submitButton.setBackgroundImage(UIImage.fromColor(UIColor(white: 1, alpha: 0.6)), forState: .Highlighted)
  }

  private func addValidationRules() {
    validator.registerField(emailTextField, errorLabel: emailErrorLabel, rules: [RequiredRule(),EmailRule()])
    validator.registerField(passwordTextField, errorLabel: passwordErrorLabel, rules: [RequiredRule(), MinLengthRule(length: 6)])
  }

  private func endEditing(textField: UITextField) {
    view.endEditing(true)
    let text = textField.text!
    if textField == emailTextField {
      newUser.email = text
    } else if textField == passwordTextField {
      newUser.password = text
    }
  }

  //MARK: User interactions
  @IBAction func submitButtonPressed(sender: UIButton) {
    view.endEditing(true)
    validator.validate { errors in
      if errors.count <= 0 {
        SwiftSpinner.show("Authenticating...")
        self.newUser.requestSignInWithCompletion { error in
          SwiftSpinner.hide()
          if let error = error {
            self.presentErrorAlertWithError(error.localizedDescription)
          } else {
            self.performSegueWithIdentifier(self.signInToHomeSegueIdentifier, sender: self)
          }
        }
      }
    }
  }

  @IBAction func inviteButtonPressed(sender: UIButton) {
    UIApplication.sharedApplication().openURL(NSURL(string: takeFodsUrl)!)
  }
}

extension SignInViewController: UITextFieldDelegate {
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    endEditing(textField)
    return true
  }

  func textFieldShouldEndEditing(textField: UITextField) -> Bool {
    endEditing(textField)
    return true
  }
}

