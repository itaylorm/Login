//
//  OnboardingViewController.swift
//  Login
//
//  Created by Taylor Maxwell on 11/24/19.
//  Copyright © 2019 Taylor Maxwell. All rights reserved.
//

import Foundation
import RxSwift

/// Handle the process of signing up or signing in the user
/// The actual sign in and sign up processes are handled
/// by other controller, this controllers handles taking user to the appropriate
/// screen based upon need (New user or existing user)
class OnboardingViewController: BaseViewController {
  
  // MARK: Properties
  
  let viewModel: OnboardingViewModel
  let disposeBag = DisposeBag()
  
  // Child View Controllers
  let welcomeViewController: WelcomeViewController
  let signInViewController: SignInViewController
  let signUpViewController: SignUpViewController
  
  // MARK: Methods
  
  /// Configures to handing onboarding with passed controllers to
  /// handle the different conditions of signing up or signing in a user
  /// - Parameters:
  ///   - viewModel: Associated type for handling displaying appropriate UI
  ///   - welcomeViewController: Handles welcoming user to system and allowing to pick sign in or sign up
  ///   - signInViewController: Handles the sign in process
  ///   - signUpViewController: Handles the sign up process
  init(viewModel: OnboardingViewModel,
       welcomeViewController: WelcomeViewController,
       signInViewController: SignInViewController,
       signUpViewController: SignUpViewController) {
    
    self.viewModel = viewModel
    self.welcomeViewController = welcomeViewController
    self.signInViewController = signInViewController
    self.signUpViewController = signUpViewController
    
    super.init()
    
  }
  
}
