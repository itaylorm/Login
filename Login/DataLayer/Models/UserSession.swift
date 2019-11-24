//
//  UserSession.swift
//  Login
//
//  Created by Taylor Maxwell on 11/23/19.
//  Copyright © 2019 Taylor Maxwell. All rights reserved.
//

import Foundation

/// Information about current logged in user's details and current logged in session information
class UserSession: Codable {
  
  /// User details
  let profile: UserProfile
  
  /// Logged in information
  let remoteSession: RemoteUserSession
  
  /// Configure information
  /// - Parameters:
  ///   - profile: User details
  ///   - remoteSession: Logged in information
  init(profile: UserProfile, remoteSession: RemoteUserSession) {
    
    self.profile = profile
    self.remoteSession = remoteSession
    
  }
  
}

/// Provides means to compare different instances
extension UserSession: Equatable {
  
  /// Compares two remote user sessions
  /// - Parameters:
  ///   - lhs: first item to compare
  ///   - rhs: second item to compare
  public static func ==(lhs: UserSession, rhs: UserSession) -> Bool {
    return lhs.profile == rhs.profile &&
      lhs.remoteSession == rhs.remoteSession
  }
  
}
