//
//  NavigationAction.swift
//  Login
//
//  Created by Taylor Maxwell on 11/24/19.
//  Copyright © 2019 Taylor Maxwell. All rights reserved.
//

import Foundation

/// Provides a means to communicate the current state of navigating to a view
/// The value of the enum indicates the application controller's current state
enum NavigationAction<Enum>: Equatable where Enum: Equatable {
  case present(state: Enum)
  case presented(state: Enum)
}
