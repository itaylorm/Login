//
//  NewAccount.swift
//  Login
//
//  Created by Taylor Maxwell on 11/23/19.
//  Copyright © 2019 Taylor Maxwell. All rights reserved.
//

import Foundation

/// Sign up information for new user
struct NewAccount: Codable {
  
  /// User full name
  let fullName: String
  
  /// User nickname
  let nickName: String
  
  /// User email
  let email: String
  
  /// User mobile number
  let mobileNumber: String
  
  /// User password
  let password: Secret
}
