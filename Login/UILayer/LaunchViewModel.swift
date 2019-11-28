//
//  LaunchViewModel.swift
//  Login
//
//  Created by Taylor Maxwell on 11/23/19.
//  Copyright © 2019 Taylor Maxwell. All rights reserved.
//

import Foundation
import PromiseKit
import RxSwift

/// Handles displaying launching screen
class LaunchViewModel: BaseViewModel {
  
  // MARK: Properties
  
  let userSessionRepository: UserSessionRepository
  let notSignedInResponder: NotSignedInResponder
  let signedInResponder: SignedInResponder
  
  let errorPresentation: BehaviorSubject<ErrorPresentation?> = BehaviorSubject(value: nil)
  
  // MARK: Methods
  
  /// Configures launch view model
  /// - Parameters:
  ///   - userSessionRepository: Reference to user session storage handler
  ///   - notSignedInResponder: Instance that handles not signed in condition
  ///   - signedInResponder: Instance that handles signed in condition
  init(userSessionRepository: UserSessionRepository,
       notSignedInResponder: NotSignedInResponder,
       signedInResponder: SignedInResponder) {
    
    self.userSessionRepository = userSessionRepository
    self.notSignedInResponder = notSignedInResponder
    self.signedInResponder = signedInResponder
    
  }
  
  /// Retrieve current user session information
  func loadUserSession() {
    
    userSessionRepository.readUserSession()
      .done(goToNextScreen(userSession:))
      .catch { error in
        
        let errorMessage = ErrorMessage(id: UUID(), title: "Sign In Error",
          message: "Sorry, we couldn't determine if you are already signed in. Please sign in or sign up.")
        self.present(errorMessage: errorMessage)
    }
  }
  
  /// Display error message
  /// - Parameter errorMessage: Message to display
  func present(errorMessage: ErrorMessage) {
    goToNextScreenAfterErrorPresentation()
    errorMessagesSubject.onNext(errorMessage)
  }
  
  /// In the case of an error go to the next screen
  func goToNextScreenAfterErrorPresentation() {
  
    _ = errorPresentation
      .filter { $0 == .dismissed }
      .take(1)
      .subscribe(onNext: { [weak self] _ in
        self?.goToNextScreen(userSession: nil)
      })
  }
  
  /// Display the next screen based upon application state
  /// - Parameter userSession: User's current information
  func goToNextScreen(userSession: UserSession?) {
    
    switch userSession {
      case .none: notSignedInResponder.notSignedIn()
      case .some(let userSession): signedInResponder.signedIn(to: userSession)
    }
  }
  
}
