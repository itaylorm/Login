//
//  UserSessionDataStore.swift
//  Login
//
//  Created by Taylor Maxwell on 11/23/19.
//  Copyright © 2019 Taylor Maxwell. All rights reserved.
//

import Foundation
import PromiseKit

public typealias AuthToken = String

/// All types that store user current logged in information must implement this protocol
/// Provides the interface by which user session (Login) information is stored
protocol UserSessionDataStore {

  /// Provide current user logged in information
  func read() -> Promise<UserSession?>

  /// Make changes to the current user logged in information
  func save(userSession: UserSession) -> Promise<(UserSession)>

  /// Removes the current user logged in information
  func delete(userSession: UserSession) -> Promise<(UserSession)>

}
