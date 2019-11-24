//
//  RemoteUserSession.swift
//  Login
//
//  Created by Taylor Maxwell on 11/23/19.
//  Copyright © 2019 Taylor Maxwell. All rights reserved.
//

import Foundation


/// Represents returned security information
struct RemoteUserSession: Codable {
  
  //MARK: Properties
  
  /// Security token returned from authentication request
  let token: AuthToken
  
}

/// Provides means to compare different instances
extension RemoteUserSession: Equatable {
  
  /// Compares two remote user sessions
  /// - Parameters:
  ///   - lhs: first item to compare
  ///   - rhs: second item to compare
  public static func ==(lhs: RemoteUserSession, rhs: RemoteUserSession) -> Bool {
    return lhs.token == rhs.token
  }
  
}

