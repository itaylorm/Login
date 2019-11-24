//
//  AuthRemoteAPI.swift
//  Login
//
//  Created by Taylor Maxwell on 11/24/19.
//  Copyright © 2019 Taylor Maxwell. All rights reserved.
//

import Foundation
import PromiseKit

/// All types that handle user authorization need to implement this protocol
protocol AuthRemoteAPI {
  
  
  /// Handles sign in web service call
  /// - Parameters:
  ///   - username: Passed user name
  ///   - password: Passed password
  func signIn(username: String, password: String) -> Promise<UserSession>
  
  /// Handes creating a new user in remote system
  /// - Parameter account: New account information
  func signUp(account: NewAccount) -> Promise<UserSession>

}
