//
//  UserSessionRepository.swift
//  Login
//
//  Created by Taylor Maxwell on 11/23/19.
//  Copyright © 2019 Taylor Maxwell. All rights reserved.
//

import Foundation
import PromiseKit

/// All types that store user session information must
/// implement this protocol
protocol UserSessionRepository {

  /// Returns the current user session login information (If there is one)
  func readUserSession() -> Promise<UserSession?>

  /// Handles creating a new user account
  /// - Parameter newAccount: user information to save in repository
  func signUp(newAccount: NewAccount) -> Promise<UserSession>

  /// Used passed credentials to generate a user session
  /// - Parameters:
  ///   - email: User email address
  ///   - password: Associated password
  func signIn(email: String, password: String) -> Promise<UserSession>

  /// Destroys the current user session
  /// - Parameter userSession: Current user session for which to sign out
  func signOut(userSession: UserSession) -> Promise<UserSession>

}
