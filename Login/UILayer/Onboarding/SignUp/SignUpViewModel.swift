//
//  SignUpViewModel.swift
//  Login
//
//  Created by Taylor Maxwell on 11/24/19.
//  Copyright © 2019 Taylor Maxwell. All rights reserved.
//

import Foundation
import RxSwift

/// Handles display of sign up screen
class SignUpViewModel: BaseViewModel {
  
  // MARK: Properties
  
  let userSessionRepository: UserSessionRepository
  let signedInResponder: SignedInResponder
  
  public let nameInput = BehaviorSubject<String>(value: "")
  public let nicknameInput = BehaviorSubject<String>(value: "")
  public let emailInput = BehaviorSubject<String>(value: "")
  public let mobileNumberInput = BehaviorSubject<String>(value: "")
  public let passwordInput = BehaviorSubject<Secret>(value: "")
  
  // MARK: Methods
  
  /// Configures view model with responder to indicate signed in status and user session storage reference
  /// - Parameters:
  ///   - userSessionRepository: Reference to storage for user session
  ///   - signedInResponder: Reference to responder for signed in status
  init(userSessionRepository: UserSessionRepository, signedInResponder: SignedInResponder) {
  
    self.userSessionRepository = userSessionRepository
    self.signedInResponder = signedInResponder
    
  }
  
  /// Gathers information and sends user information to the user repository
  @objc public func signUp() {
    
    let (name, nickname, email, mobileNumber, password) = getFieldValues()
    let newAccount = NewAccount(fullName: name, nickName: nickname, email: email, mobileNumber: mobileNumber, password: password)
    
    userSessionRepository.signUp(newAccount: newAccount)
      .done(signedInResponder.signedIn(to:))
      .catch(handleSignUpError)
  }

  
  /// Retrieves user information
  func getFieldValues() -> (String, String, String, String, Secret) {
    
    do {
      let name = try nameInput.value()
      let nickname = try nicknameInput.value()
      let email = try emailInput.value()
      let mobileNumber = try mobileNumberInput.value()
      let password = try passwordInput.value()
      return (name, nickname, email, mobileNumber, password)
    } catch {
      fatalError("Error accessing field values from sign up screen.")
    }
  }

  func handleSignUpError(_ error: Error) {
    errorMessagesSubject.onNext(ErrorMessage(id: UUID(), title: "Sign Up Failed",
                                             message: "Could not sign up.\nPlease try again."))
  }
  
}
