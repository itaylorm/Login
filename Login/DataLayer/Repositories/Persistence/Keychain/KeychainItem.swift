//
//  KeyChainItem.swift
//  Login
//
//  Created by Taylor Maxwell on 11/24/19.
//  Copyright © 2019 Taylor Maxwell. All rights reserved.
//

import Foundation

/// Represents an item to be saved on Key store
class KeychainItem {

  // MARK: - Properties
  let service: NSString = "KooberCloud"
  let itemClass = kSecClass as String
  let itemService = kSecAttrService as String

  // MARK: - Methods
  
  /// Converts to key value pairs
  func asDictionary() -> CFDictionary {
    let item: [String: AnyObject] = [itemClass: kSecClassGenericPassword,
                                     itemService: service]
    return item as CFDictionary
  }
  
}
