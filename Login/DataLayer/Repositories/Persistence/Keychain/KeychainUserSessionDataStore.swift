//
//  KeychainUserSessionDataStore.swift
//  Login
//
//  Created by Taylor Maxwell on 11/24/19.
//  Copyright © 2019 Taylor Maxwell. All rights reserved.
//

import Foundation
import UIKit
import PromiseKit

/// Provides a means to store user login information in storage system
class KeychainUserSessionDataStore: UserSessionDataStore {

  // MARK: - Properties

  let userSessionCoder: UserSessionCoding

  // MARK: - Methods

  /// Configures to work with passed encoding system
  /// - Parameter userSessionCoder: Reference to encoding/decoding system
  init(userSessionCoder: UserSessionCoding) {
    self.userSessionCoder = userSessionCoder
  }

  func read() -> Promise<UserSession?> {
    return Promise<UserSession?> { seal in
      DispatchQueue.global().async {
        self.readUserSessionSync(seal: seal)
      }
    }
  }

  /// Save user information in the key chain
  /// - Parameter userSession: User information to save
  func save(userSession: UserSession) -> Promise<(UserSession)> {
    let data = userSessionCoder.encode(userSession: userSession)
    let item = KeychainItemWithData(data: data)
    return self.read()
                  .map { userSessionFromKeychain -> UserSession in
                    if userSessionFromKeychain == nil {
                      try Keychain.save(item: item)
                    } else {
                      try Keychain.update(item: item)
                    }
                    return userSession
                  }
  }

  func delete(userSession: UserSession) -> Promise<(UserSession)> {
    return Promise<UserSession> { seal in
      DispatchQueue.global().async {
        self.deleteSync(userSession: userSession, seal: seal)
      }
    }
  }
}

extension KeychainUserSessionDataStore {

  func readUserSessionSync(seal: Resolver<UserSession?>) {
    do {
      let query = KeychainItemQuery()
      if let data = try Keychain.findItem(query: query) {
        let userSession = self.userSessionCoder.decode(data: data)
        seal.fulfill(userSession)
      } else {
        seal.fulfill(nil)
      }
    } catch {
      seal.reject(error)
    }
  }

  func deleteSync(userSession: UserSession, seal: Resolver<UserSession>) {
    do {
      let item = KeychainItem()
      try Keychain.delete(item: item)
      seal.fulfill(userSession)
    } catch {
      seal.reject(error)
    }
  }
}

enum KeychainUserSessionDataStoreError: Error {

  case typeCast
  case unknown
}
