//
//  OnboardingDependencyContainer.swift
//  Login
//
//  Created by Taylor Maxwell on 11/24/19.
//  Copyright © 2019 Taylor Maxwell. All rights reserved.
//

import Foundation

/// Configures all the controllers and associated view models that
/// handles the process of logging in or signing up a user
class OnboardingDependencyContainer: WelcomeViewModelFactory, SignInViewModelFactory, SignUpViewModelFactory {

  // MARK: Properties
  
  let userSessionRepository: UserSessionRepository
  let mainViewModel: MainViewModel
  
  let onboardingViewModel: OnboardingViewModel
  
  // MARK: Methods
  
  /// Configures on boarding dependencies
  /// - Parameter appDependencyContainer: Main application dependency reference
  init(appDependencyContainer: AppDependencyContainer) {
    
    onboardingViewModel = OnboardingViewModel()
    
    self.userSessionRepository = appDependencyContainer.userSessionRepository
    self.mainViewModel = appDependencyContainer.mainViewModel
    
    
  }
  
  /// Provides a means to generate on boarding controller with dependencies
  func makeOnboardingViewController() -> OnboardingViewController {
    
    let welcomeViewController = makeWelcomeViewController()
    let signInViewController = makeSignInViewController()
    let signUpViewController = makeSignUpViewController()
    
    return OnboardingViewController(viewModel: onboardingViewModel,
                                    welcomeViewController: welcomeViewController,
                                    signInViewController: signInViewController,
                                    signUpViewController: signUpViewController)
  }
  
  /// Generates dependencies and return Welcome view controller
  func makeWelcomeViewController() -> WelcomeViewController {
    return WelcomeViewController(welcomeViewModelFactory: self)
  }
  
  /// Generates welcome view model required to create welcome controller
  /// Used by the controller to generate view model
  func makeWelcomeViewModel() -> WelcomeViewModel {
    
    return WelcomeViewModel(signInNavigator: onboardingViewModel, signUpNavigator: onboardingViewModel)
  
  }
  
  /// Generates dependencies and return sign in view controller
  func makeSignInViewController() -> SignInViewController {
    
    return SignInViewController(signInViewModelFactory: self)
    
  }
  
  /// Generates sign in view model required to create sign in controller
  /// Used by the controller to generate view model
  func makeSignInViewModel() -> SignInViewModel {
    
    return SignInViewModel(userSessionRepository: userSessionRepository, signedInResponder: mainViewModel)
    
  }
  
  /// Generates dependencies and return sign up view controller
  func makeSignUpViewController() -> SignUpViewController {
    
    return SignUpViewController(signUpViewModelFactory: self)
    
  }
  
  /// Generates sign up view model required to create sign up controller
  /// Used by the controller to generate view model
  func makeSignUpViewModel() -> SignUpViewModel {
    
    return SignUpViewModel(userSessionRepository: userSessionRepository, signedInResponder: mainViewModel)
    
  }
  
}
