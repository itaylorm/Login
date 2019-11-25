//
//  SignUpViewController.swift
//  Login
//
//  Created by Taylor Maxwell on 11/24/19.
//  Copyright © 2019 Taylor Maxwell. All rights reserved.
//

import Foundation

/// Handles the process of allowing the user to sign up
class SignUpViewController: BaseViewController {
  
  // MARK: Properties
  
  let signUpViewModelFactory: SignUpViewModelFactory
  
  // MARK: Methods
  
  /// Initializes controller with associated view model
  /// - Parameter signUpViewModelFactory: Provides view model for display sign up
  init(signUpViewModelFactory: SignUpViewModelFactory) {
    
    self.signUpViewModelFactory = signUpViewModelFactory
    
    super.init()
    
  }
}

/// Handles generating welcome view model
protocol SignUpViewModelFactory {
  
  /// Generates sign up view model for handling displaying sign up
  func makeSignUpViewModel() -> SignUpViewModel
  
}
