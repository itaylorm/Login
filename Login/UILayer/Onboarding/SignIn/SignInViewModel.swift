//
//  SignInViewModel.swift
//  Login
//
//  Created by Taylor Maxwell on 11/24/19.
//  Copyright © 2019 Taylor Maxwell. All rights reserved.
//

import Foundation

/// Handles display of sign in screen
class SignInViewModel: BaseViewModel {

  // MARK: Properties

  let userSessionRepository: UserSessionRepository
  let signedInResponder: SignedInResponder

  // MARK: Methods

  /// Configures view model with responder to indicate signed in status and user session storage reference
  /// - Parameters:
  ///   - userSessionRepository: Reference to storage for user session
  ///   - signedInResponder: Reference to responder for signed in status
  init(userSessionRepository: UserSessionRepository, signedInResponder: SignedInResponder) {

    self.userSessionRepository = userSessionRepository
    self.signedInResponder = signedInResponder

  }

}
