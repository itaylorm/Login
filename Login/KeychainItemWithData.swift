//
//  KeyChainItemWithData.swift
//  Login
//
//  Created by Taylor Maxwell on 11/24/19.
//  Copyright © 2019 Taylor Maxwell. All rights reserved.
//

import Foundation

/// Represents an item to be stored in key store with associated data
class KeychainItemWithData: KeychainItem {

  // MARK: - Properties
  let data: AnyObject
  let itemData = kSecValueData as String

  // MARK: - Methods
  init(data: Data) {
    self.data = data as AnyObject
  }

  /// Returns key value pairs
  override func asDictionary() -> CFDictionary {
    let item: [String: AnyObject] = [itemClass: kSecClassGenericPassword,
                                     itemService: service,
                                     itemData: data]
    return item as CFDictionary
  }

  /// Returns CF Dictionary of items
  func attributesAsDictionary() -> CFDictionary {
    let attributes: [String: AnyObject] = [itemClass: kSecClassGenericPassword,
                                           itemService: service]
    return attributes as CFDictionary
  }

  /// Returns data 
  func dataAsDictionary() -> CFDictionary {
    let justData: [String: AnyObject] = [itemData: data]
    return justData as CFDictionary
  }
}
