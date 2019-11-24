//
//  UserSessionCoding.swift
//  Login
//
//  Created by Taylor Maxwell on 11/24/19.
//  Copyright © 2019 Taylor Maxwell. All rights reserved.
//

import Foundation

/// Handles changing user information from Data to user session and back
protocol UserSessionCoding {
  
  /// Convert UserSession to Data
  /// - Parameter userSession: User login information to convert
  func encode(userSession: UserSession) -> Data
  
  
  /// Convert Data into User Session
  /// - Parameter data: Encoded User session to convert
  func decode(data: Data) -> UserSession
}
