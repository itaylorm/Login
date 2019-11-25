//
//  LaunchRootView.swift
//  Login
//
//  Created by Taylor Maxwell on 11/23/19.
//  Copyright © 2019 Taylor Maxwell. All rights reserved.
//

import Foundation
import UIKit

class LaunchView: BaseView {
  
  // MARK: Properties
  
  let viewModel: LaunchViewModel
  
  // MARK: Methods
  
  /// Configure settings associated with view
  /// - Parameters:
  ///   - frame: View information
  ///   - viewModel: Reference to associated LaunchViewModel
  init(frame: CGRect = .zero, viewModel: LaunchViewModel) {
    
    self.viewModel = viewModel
    super.init(frame: frame)
    
    backgroundColor = UIColor.red
    viewModel.loadUserSession()
    
  }
  
}
