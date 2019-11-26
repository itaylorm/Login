//
//  Onboarding.swift
//  Login
//
//  Created by Taylor Maxwell on 11/24/19.
//  Copyright © 2019 Taylor Maxwell. All rights reserved.
//

import Foundation

/// Different states of the on boarding process
/// This is used to indicate which view to display to user
enum OnboardingState {
  
  case welcome
  case signin
  case signup
 
  /// Handles whether to show navigation bar
  func hidesNavigationBar() -> Bool {
    
    switch self {
      
      case .welcome: return true
      default: return false
      
    }
  }
  
}
