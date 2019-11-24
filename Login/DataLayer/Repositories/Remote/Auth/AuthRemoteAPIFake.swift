//
//  AuthRemoteAPIFake.swift
//  Login
//
//  Created by Taylor Maxwell on 11/24/19.
//  Copyright © 2019 Taylor Maxwell. All rights reserved.
//

import Foundation
import PromiseKit

/// A simulated we server remote API provider
struct AuthRemoteAPIFake: AuthRemoteAPI {

  /// Default init
  init() {}

  /// Simulates logging in
  /// - Parameters:
  ///   - username: Passed user name
  ///   - password: Passed password
  func signIn(username: String, password: String) -> Promise<UserSession> {
    
    guard username == "johnny@gmail.com" && password == "password" else {
      return Promise(error: AppError.any)
    }
    
    return Promise<UserSession> { seal in
      
      DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
        let profile = UserProfile(name: "Johnny Appleseed",
                                  email: "johnny@gmail.com",
                                  mobileNumber: "510-736-8754",
                                  avatarUrl: self.makeURL())
        let remoteUserSession = RemoteUserSession(token: "64652626")
        let userSession = UserSession(profile: profile, remoteSession: remoteUserSession)
        seal.fulfill(userSession)
      }
      
    }
  }

  /// Simulates signing up new user
  /// - Parameter account: New Account information
  func signUp(account: NewAccount) -> Promise<UserSession> {
    
    let profile = UserProfile(name: account.fullName,
                              email: account.email,
                              mobileNumber: account.mobileNumber,
                              avatarUrl: self.makeURL())
    
    let remoteUserSession = RemoteUserSession(token: "984270985")
    let userSession = UserSession(profile: profile, remoteSession: remoteUserSession)
    return .value(userSession)
    
  }
  
  /// Generates fake URL
  private func makeURL() -> URL {
    
    return URL(string: "http://www.koober.com/avatar/johnnya")!
  }
  
}
