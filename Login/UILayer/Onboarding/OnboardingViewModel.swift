//
//  OnboardingViewModel.swift
//  Login
//
//  Created by Taylor Maxwell on 11/24/19.
//  Copyright © 2019 Taylor Maxwell. All rights reserved.
//

import Foundation
import RxSwift

typealias OnboardingNavigationAction = NavigationAction<Onboarding>

/// Handles the different conditions of starting up onboarding process
class OnboardingViewModel: SignUpNavigator, SignInNavigator {
  
  // MARK: Properties
  
  var _view = BehaviorSubject<OnboardingNavigationAction>(value: .present(view: .welcome))
  var view: Observable<OnboardingNavigationAction> { return _view }
  
  // MARK: Methods
  
  /// Default initializer
  init() {}
  
  /// Takes user to the sign in view
  func SignUp() {
    _view.onNext(.present(view: .signup))
  }
  
  /// Takes user to the sign in view
  func SignIn() {
    _view.onNext(.present(view: .signin))
  }
  
}
