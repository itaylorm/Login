//
//  MainViewModel.swift
//  Login
//
//  Created by Taylor Maxwell on 11/23/19.
//  Copyright © 2019 Taylor Maxwell. All rights reserved.
//

import Foundation
import RxSwift

/// Handles the different conditions of starting up main view
class MainViewModel: SignedInResponder, NotSignedInResponder {
  
  // MARK: Properties
  
  var view: Observable<MainView> { return viewSubject.asObservable() }
  
  private let viewSubject = BehaviorSubject<MainView>(value: .launching)

  // MARK: Methods
  
  /// Indicates user is not signed in
  func notSignedIn() {
    viewSubject.onNext(.onboarding)
  }
  
  /// Indicates user is signed in along with current associated information
  /// - Parameter userSession: Logged in information
  func signedIn(to userSession: UserSession) {
    viewSubject.onNext(.signedIn(userSession: userSession))
  }
  
}
