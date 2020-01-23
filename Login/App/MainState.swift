//
//  MainView.swift
//  Login
//
//  Created by Taylor Maxwell on 11/23/19.
//  Copyright © 2019 Taylor Maxwell. All rights reserved.
//

import Foundation

/// Provides a means to determine which part of the
/// application cycle the app is in
enum MainState {

  case launching
  case onboarding
  case signedIn(userSession: UserSession)

}

/// Provides mean to compare enum values
extension MainState: Equatable {

  static func == (lhs: MainState, rhs: MainState) -> Bool {

    switch(lhs, rhs) {
    case (.launching, .launching): return true
    case (.onboarding, .onboarding) : return true
    case let (.signedIn(left), .signedIn(right)): return left == right
    case (.launching, _),
         (.onboarding, _),
         (.signedIn, _):
          return false
    }
  }

}
