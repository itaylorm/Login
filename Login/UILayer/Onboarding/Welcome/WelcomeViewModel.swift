//
//  WelcomeViewModel.swift
//  Login
//
//  Created by Taylor Maxwell on 11/24/19.
//  Copyright © 2019 Taylor Maxwell. All rights reserved.
//

import Foundation

/// Handles display of welcome screen
class WelcomeViewModel: BaseViewModel {
  
  // MARK: Properties
  
  let signUpNavigator: SignUpNavigator
  let signInNavigator: SignInNavigator
  
  // MARK: Methods
  
  /// Configures view model with associated types that handle going to sign up and sign in
  /// - Parameters:
  ///   - signInNavigation: Reference that will handle going to sign in
  ///   - signUpNavigator: reference that will handle going to sign up
  init(signInNavigator: SignInNavigator, signUpNavigator: SignUpNavigator) {
    
    self.signInNavigator = signInNavigator
    self.signUpNavigator = signUpNavigator
    
  }
  
  /// Takes user to the sign up view
  @objc func showSignUpView() {
    signUpNavigator.SignUp()
  }
  
  /// Takes user to the sign in view
  @objc func showSignInView() {
    signInNavigator.SignIn()
  }
  
}
