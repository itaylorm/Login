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

    // swiftlint:disable:next force_try
    return try! PropertyListEncoder().encode(userSession)
    // swiftlint:enable force_try

  }

  /// Convert Data into User Session
  /// - Parameter data: Encoded User session to convert
  func decode(data: Data) -> UserSession {

    // swiftlint:disable:next force_try
    return try! PropertyListDecoder().decode(UserSession.self, from: data)
    // swiftlint:enable force_try

  }
}
