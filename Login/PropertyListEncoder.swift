//
//  PropertyListEncoder.swift
//  Login
//
//  Created by Taylor Maxwell on 11/24/19.
//  Copyright © 2019 Taylor Maxwell. All rights reserved.
//

import Foundation

/// Handles changing user information from Data to user session and back
public class UserSessionPropertyListCoder: UserSessionCoding {

  // MARK: - Methods
  public init() {}

  /// Convert UserSession to Data
  /// - Parameter userSession: User login information to convert
  func encode(userSession: UserSession) -> Data {
    return try! PropertyListEncoder().encode(userSession)
  }

  /// Convert Data into User Session
  /// - Parameter data: Encoded User session to convert
  func decode(data: Data) -> UserSession {
    return try! PropertyListDecoder().decode(UserSession.self, from: data)
  }
}
