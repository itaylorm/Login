//
//  ErrorMessage.swift
//  Login
//
//  Created by Taylor Maxwell on 11/23/19.
//  Copyright © 2019 Taylor Maxwell. All rights reserved.
//

import Foundation

/// An exception message to displlay to user
public struct ErrorMessage: Error {

  // MARK: - Properties

  // Associated id
  let identifier: UUID

  // Top level message
  let title: String

  // Main message
  let message: String

}

/// Provides a means to compare different instances
extension ErrorMessage: Equatable {

  /// Compares two remote user sessions
  /// - Parameters:
  ///   - lhs: first item to compare
  ///   - rhs: second item to compare
  public static func == (lhs: ErrorMessage, rhs: ErrorMessage) -> Bool {
    return lhs.identifier == rhs.identifier
  }

}
