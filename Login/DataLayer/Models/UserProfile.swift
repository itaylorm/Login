//
//  UserProfile.swift
//  Login
//
//  Created by Taylor Maxwell on 11/23/19.
//  Copyright © 2019 Taylor Maxwell. All rights reserved.
//

import Foundation

/// Information about logged in user
struct UserProfile: Equatable, Codable {
  
  //MARK: Properties

  /// Full Name
  let name: String
  
  /// User's email address
  let email: String
  
  /// User's phone number
  let mobileNumber: String
  
  /// User's avatar image url (if any)
  let avatarUrl: URL
  
}
