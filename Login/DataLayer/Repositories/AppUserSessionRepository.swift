//
//  AppUserSessionRepository.swift
//  Login
//
//  Created by Taylor Maxwell on 11/24/19.
//  Copyright © 2019 Taylor Maxwell. All rights reserved.
//

import Foundation
import PromiseKit

/// Handles user session 
class AppUserSessionRepository: UserSessionRepository {

  // MARK: - Properties

  let dataStore: UserSessionDataStore
  let remoteAPI: AuthRemoteAPI

  // MARK: - Methods

  /// Configure application data store
  /// - Parameters:
  ///   - dataStore: Reference to associated data store
  ///   - remoteAPI: Reference to API system
  init(dataStore: UserSessionDataStore, remoteAPI: AuthRemoteAPI) {

    self.dataStore = dataStore
    self.remoteAPI = remoteAPI

  }

  /// <#Description#>
  public func readUserSession() -> Promise<UserSession?> {

    return dataStore.read()

  }

  /// Create new user account
  /// - Parameter newAccount: New account information
  public func signUp(newAccount: NewAccount) -> Promise<UserSession> {

    return remoteAPI.signUp(account: newAccount)
            .then(dataStore.save(userSession:))

  }

  /// Begin user session
  /// - Parameters:
  ///   - email: passed email address
  ///   - password: passed password
  public func signIn(email: String, password: String) -> Promise<UserSession> {

    return remoteAPI.signIn(username: email, password: password)
            .then(dataStore.save(userSession:))

  }

  /// End current user session
  /// - Parameter userSession: <#userSession description#>
  public func signOut(userSession: UserSession) -> Promise<UserSession> {

    return dataStore.delete(userSession: userSession)

  }

}
