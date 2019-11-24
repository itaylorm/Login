//
//  KeychainItemQuery.swift
//  Login
//
//  Created by Taylor Maxwell on 11/24/19.
//  Copyright © 2019 Taylor Maxwell. All rights reserved.
//

import Foundation

/// Associated query for key chain for queries
class KeychainItemQuery: KeychainItem {

  // MARK: - Properties
  let matchLimit = kSecMatchLimit as String
  let returnData = kSecReturnData as String

  // MARK: - Methods
  override func asDictionary() -> CFDictionary {
    let query: [String: AnyObject] = [itemClass: kSecClassGenericPassword,
                                      itemService: service,
                                      matchLimit: kSecMatchLimitOne,
                                      returnData: kCFBooleanTrue]
    return query as CFDictionary
  }
  
}
