//
//  Keychain.swift
//  Login
//
//  Created by Taylor Maxwell on 11/24/19.
//  Copyright © 2019 Taylor Maxwell. All rights reserved.
//

import Foundation

/// Provides access to the key chain store with CRUD methods
class Keychain {

  /// Returns key entries stored in system
  /// - Parameter query: Query details for which to return keys
  static func findItem(query: KeychainItemQuery) throws -> Data? {

    var queryResult: AnyObject?
    let status = withUnsafeMutablePointer(to: &queryResult) {
      SecItemCopyMatching(query.asDictionary(), UnsafeMutablePointer($0))
    }

    if status == errSecItemNotFound {
      return nil
    }

    guard status == noErr else {
      throw KeychainUserSessionDataStoreError.unknown
    }

    guard let itemData = queryResult as? Data else {
      throw KeychainUserSessionDataStoreError.typeCast
    }

    return itemData
  }

  /// Save key to the key store
  /// - Parameter item: Item to save
  static func save(item: KeychainItemWithData) throws {

    let status = SecItemAdd(item.asDictionary(), nil)

    guard status == noErr else {
      throw KeychainUserSessionDataStoreError.unknown
    }

  }

  /// Update existing key in key store
  /// - Parameter item: Item to update
  static func update(item: KeychainItemWithData) throws {

    let status = SecItemUpdate(item.attributesAsDictionary(), item.dataAsDictionary())

    guard status == noErr else {
      throw KeychainUserSessionDataStoreError.unknown
    }

  }

  /// Remove item from key store
  /// - Parameter item: Item to remove
  static func delete(item: KeychainItem) throws {

    let status = SecItemDelete(item.asDictionary())

    guard status == noErr || status == errSecItemNotFound else {
      throw KeychainUserSessionDataStoreError.unknown
    }

  }
}
