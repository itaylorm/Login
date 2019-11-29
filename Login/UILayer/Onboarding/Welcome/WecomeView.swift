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
  
  let topView: UIView = {
      
    let topView = UIView()
    topView.translatesAutoresizingMaskIntoConstraints = false
    return topView
  }()
  
  let bottomView: UIView = {
      
    let bottomView = UIView()
    bottomView.translatesAutoresizingMaskIntoConstraints = false
    return bottomView
  }()
  
  let appLogoImageView: UIImageView = {
  
    let imageView = UIImageView(image: UIImage(named: "Welcome"))
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFit
    return imageView
    
  }()

  let signInButton: UIButton = {
    
    let button = UIButton(type: .custom)
    button.setTitle("Sign In", for: .normal)
    button.titleLabel?.font = Button.font
    button.layer.borderWidth = Button.borderWidth
    button.layer.cornerRadius = Button.cornerRadius
    button.layer.borderColor = Button.borderColor
    button.layer.backgroundColor = Button.backgroundColor
    button.heightAnchor.constraint(equalToConstant: Button.height).isActive = true
    button.widthAnchor.constraint(equalToConstant: Button.width).isActive = true
    
    return button
    
  }()

  let signUpButton: UIButton = {
    
    let button = UIButton(type: .custom)
    button.setTitle("Sign Up?", for: .normal)
    button.setTitleColor(Color.primary, for: .normal)
    button.titleLabel?.font = Button.font
    button.heightAnchor.constraint(equalToConstant: Button.height).isActive = true
    return button
    
  }()

  lazy var buttonStackView: UIStackView = {
    let stackView =
      UIStackView(arrangedSubviews: [signInButton, signUpButton])
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    stackView.alignment = .center
    stackView.spacing = 10
    return stackView
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
    
    constructHierarchy()
    activateConstraints()

    signInButton.addTarget(viewModel,
                           action: #selector(WelcomeViewModel.showSignInView),
                           for: .touchUpInside)
    signUpButton.addTarget(viewModel,
                           action: #selector(WelcomeViewModel.showSignUpView),
                           for: .touchUpInside)
    hierarchyNotReady = false
    
  }
  
  /// Assemble controls on screen
  func constructHierarchy() {
    
    addSubview(topView)
    topView.addSubview(appLogoImageView)
    
    addSubview(bottomView)
    bottomView.addSubview(buttonStackView)
    
  }

  /// Apply control constraints
  func activateConstraints() {
    
    activateContraintsTopView()
    activateConstraintsAppLogo()
    activateContraintsBottomView()
    activateConstraintsButtons()
    
  }

  /// Configure the top container to fill top of screen
  func activateContraintsTopView() {
  
    let top = topView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor)
    let height = topView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.6)
    let left = topView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor)
    let right = topView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
    NSLayoutConstraint.activate([top, height, left, right])
  
  }
  
  /// Configure the top container to fill bottom of screen
  func activateContraintsBottomView() {
  
    let bottom = bottomView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
    let height = bottomView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.4)
    let left = bottomView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor)
    let right = bottomView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
    NSLayoutConstraint.activate([bottom, height, left, right])
  
  }
  
  /// Apply logo constraints to position on screen
  func activateConstraintsAppLogo() {
    
    let top = appLogoImageView.topAnchor.constraint(equalTo: topView.topAnchor, constant: 25)
    let centerX = appLogoImageView.centerXAnchor.constraint(equalTo: topView.centerXAnchor)
    let height = appLogoImageView.heightAnchor.constraint(equalTo: topView.heightAnchor, multiplier: 0.8)
    let width = appLogoImageView.widthAnchor.constraint(equalTo: topView.widthAnchor, multiplier: 0.8)
    NSLayoutConstraint.activate([top, centerX, height, width])
    
  }

  /// Apply button constrains and position on screen
  func activateConstraintsButtons() {
    
    let leading = buttonStackView.leadingAnchor
      .constraint(equalTo: layoutMarginsGuide.leadingAnchor)
    
    let trailing = buttonStackView.trailingAnchor
      .constraint(equalTo: layoutMarginsGuide.trailingAnchor)
    
    let bottom = safeAreaLayoutGuide.bottomAnchor
      .constraint(equalTo: buttonStackView.bottomAnchor, constant: 30)
    
    NSLayoutConstraint.activate([leading, trailing, bottom])
    
  }
  
}
