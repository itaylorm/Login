//
//  SignedInResponder.swift
//  Login
//
//  Created by Taylor Maxwell on 11/23/19.
//  Copyright © 2019 Taylor Maxwell. All rights reserved.
//

import Foundation

/// Handles successful sign in
protocol SignedInResponder {

  /// Indicates user is signed in along with current associated information
  /// - Parameter userSession: Logged in information
  func signedIn(to userSession: UserSession)

}
