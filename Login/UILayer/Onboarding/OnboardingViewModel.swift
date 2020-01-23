//
//  OnboardingViewModel.swift
//  Login
//
//  Created by Taylor Maxwell on 11/24/19.
//  Copyright © 2019 Taylor Maxwell. All rights reserved.
//

import Foundation
import RxSwift

typealias OnboardingNavigationAction = NavigationAction<OnboardingState>

/// Handles the different conditions of starting up onboarding process
class OnboardingViewModel: BaseViewModel, SignUpNavigator, SignInNavigator {

  // MARK: Properties

  var onboardingView = BehaviorSubject<OnboardingNavigationAction>(value: .present(state: .welcome))
  var view: Observable<OnboardingNavigationAction> { return onboardingView }

  // MARK: Methods

  /// Takes user to the sign in view
  func signUp() {
    onboardingView.onNext(.present(state: .signup))
  }

  /// Takes user to the sign in view
  func signIn() {
    onboardingView.onNext(.present(state: .signin))
  }

  /// Triggers when view displayed to user
  /// - Parameter onboarding: Represents the state of the on boarding process
  public func uiPresented(onboarding: OnboardingState) {

    onboardingView.onNext(.presented(state: onboarding))

  }

}
