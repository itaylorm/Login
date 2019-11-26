//
//  WecomeView.swift
//  Login
//
//  Created by Taylor Maxwell on 11/24/19.
//  Copyright © 2019 Taylor Maxwell. All rights reserved.
//

import UIKit

/// Handles appearance of welcome UI
class WelcomeView: BaseView {
  
  let viewModel: WelcomeViewModel
  var hierarchyNotReady = true
  
  let appLogoImageView: UIImageView = {
  
    let imageView = UIImageView(image: UIImage(named: "iMaxwell"))
    imageView.backgroundColor = UIColor.green
    return imageView
    
  }()
  
  // MARK: - Methods
  
  /// Configures view
  /// - Parameters:
  ///   - frame: Bounds of the view
  ///   - viewModel: Associated view model
  init(frame: CGRect = .zero,
       viewModel: WelcomeViewModel) {
    self.viewModel = viewModel
    super.init(frame: frame)
  }
  
  /// Triggers when window becomes available
  override func didMoveToWindow() {
    
    super.didMoveToWindow()
    
    guard hierarchyNotReady else { return }
    
    backgroundColor = UIColor.green
    
    addSubview(appLogoImageView)
    
  }
}
