//
//  LightTheme.swift
//  Login
//
//  Created by Taylor Maxwell on 11/27/19.
//  Copyright © 2019 Taylor Maxwell. All rights reserved.
//

import UIKit

struct LightTheme: Theme {
  
  let tint: UIColor = .blue
  let secondaryTint: UIColor = .orange
  let iconTint: UIColor = .white
  
  let backgroundColor: UIColor = .white
  let separatorColor: UIColor = .lightGray
  let selectionColor: UIColor = .init(red: 236/255, green: 236/255, blue: 236/255, alpha: 1)

  let labelColor: UIColor = .black
  let secondaryLabelColor: UIColor = .darkGray
  let subtleLabelColor: UIColor = .lightGray

  let barStyle: UIBarStyle = .default

  let borderColor: CGColor = UIColor.black.cgColor
  
}
