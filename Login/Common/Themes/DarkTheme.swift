//
//  DarkTheme.swift
//  Login
//
//  Created by Taylor Maxwell on 11/27/19.
//  Copyright © 2019 Taylor Maxwell. All rights reserved.
//

import UIKit

struct DarkTheme: Theme {
  
  let primary: UIColor = Color.primary
  let tint: UIColor = .white
  let secondaryTint: UIColor = .systemGreen
  let iconTint: UIColor = .systemYellow
  
  let backgroundColor: UIColor = .black
  let separatorColor: UIColor = .lightGray
  let selectionColor: UIColor = .init(red: 38/255, green: 38/255, blue: 40/255, alpha: 1)

  let labelColor: UIColor = .white
  let secondaryLabelColor: UIColor = .lightGray
  let subtleLabelColor: UIColor = .darkGray
  let titleLabelColor: UIColor = .white
  
  let barStyle: UIBarStyle = .black

  let borderColor: CGColor = UIColor.white.cgColor
  
}
