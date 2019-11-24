//
//  MainView.swift
//  Login
//
//  Created by Taylor Maxwell on 11/23/19.
//  Copyright © 2019 Taylor Maxwell. All rights reserved.
//

import Foundation

enum MainView {
  
  case launching
  case onboarding
  case signedIn(userSession: UserSession)
  
}

extension MainView: Equatable {
  
  static func ==(lhs: MainView, rhs: MainView) -> Bool {
    
    switch(lhs, rhs) {
      case (.launching, .launching): return true
      case (.onboarding, .onboarding) : return true
      case let (.signedIn(l), .signedIn(r)): return l == r
      case (.launching, _),
         (.onboarding, _),
         (.signedIn, _):
          return false
    }
  }
  
}
