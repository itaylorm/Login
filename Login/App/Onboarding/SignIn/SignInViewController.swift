//
//  SignInViewController.swift
//  Login
//
//  Created by Taylor Maxwell on 11/24/19.
//  Copyright © 2019 Taylor Maxwell. All rights reserved.
//

import Foundation

/// Handles the process of allowing the user to login
class SignInViewController: BaseViewController {
  
  // MARK: Properties
  
  let signInViewModelFactory: SignInViewModelFactory
  
  // MARK: Methods
  
  /// Initializes controller with associated view model
  /// - Parameter signInViewModelFactory: Provides view model for display sign in
  init(signInViewModelFactory: SignInViewModelFactory) {
    
    self.signInViewModelFactory = signInViewModelFactory
    
    super.init()
    
  }
}

/// Handles generating sign in view model
protocol SignInViewModelFactory {
  
  /// Generates sign up view model for handling displaying sign in
  func makeSignInViewModel() -> SignInViewModel
  
}
