//
//  NavigationAction.swift
//  Login
//
//  Created by Taylor Maxwell on 11/24/19.
//  Copyright © 2019 Taylor Maxwell. All rights reserved.
//

import Foundation

/// Provides a means to communicate the current state of navigating to a view
enum NavigationAction<ViewModelType>: Equatable where ViewModelType: Equatable {
  
  case present(view: ViewModelType)
  case presented(view: ViewModelType)
}
