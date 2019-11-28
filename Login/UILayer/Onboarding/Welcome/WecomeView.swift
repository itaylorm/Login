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
    //imageView.backgroundColor = Color.primary
    return imageView
    
  }()
  
  let appNameLabel: UILabel = {
    let label = UILabel()
    label.font = .boldSystemFont(ofSize: 36)
    label.text = "KOOBER"
    return label
  }()

  let signInButton: UIButton = {
    let button = UIButton(type: .custom)
    button.setTitle("Sign In", for: .normal)
    button.titleLabel?.font = .boldSystemFont(ofSize: 18)
    button.heightAnchor
      .constraint(equalToConstant: 50)
      .isActive = true
    return button
  }()

  let signUpButton: UIButton = {
    let button = UIButton(type: .custom)
    button.setTitle("Sign Up", for: .normal)
    button.titleLabel?.font = .boldSystemFont(ofSize: 18)
    button.heightAnchor
      .constraint(equalToConstant: 50)
      .isActive = true
    return button
  }()

  lazy var buttonStackView: UIStackView = {
    let stackView =
      UIStackView(arrangedSubviews: [signInButton, signUpButton])
    stackView.axis = .horizontal
    stackView.distribution = .fillEqually
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
    
    //backgroundColor = Color.primary
  
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
    
    addSubview(appLogoImageView)
    addSubview(buttonStackView)
    
  }

  /// Apply control constraints
  func activateConstraints() {
    
    activateConstraintsAppLogo()
    activateConstraintsButtons()
    
  }

  /// Apply logo constraints to position on screen
  func activateConstraintsAppLogo() {
    
    appLogoImageView.translatesAutoresizingMaskIntoConstraints = false
    let centerY = appLogoImageView.centerYAnchor
      .constraint(equalTo: centerYAnchor)
    
    let centerX = appLogoImageView.centerXAnchor
      .constraint(equalTo: centerXAnchor)
    
    NSLayoutConstraint.activate([centerY, centerX])
    
  }
  
  /// Apply label constrains to position on screen
  func activateConstraintsAppNameLabel() {
    
    appNameLabel.translatesAutoresizingMaskIntoConstraints = false
    
    let centerX = appNameLabel.centerXAnchor
      .constraint(equalTo: appLogoImageView.centerXAnchor)
    
    let top = appNameLabel.topAnchor
      .constraint(equalTo: appLogoImageView.bottomAnchor, constant: 10)
    
    NSLayoutConstraint.activate([centerX, top])
    
  }

  /// Apply button constrains and position on screen
  func activateConstraintsButtons() {
    
    buttonStackView.translatesAutoresizingMaskIntoConstraints = false
    let leading = buttonStackView.leadingAnchor
      .constraint(equalTo: layoutMarginsGuide.leadingAnchor)
    
    let trailing = buttonStackView.trailingAnchor
      .constraint(equalTo: layoutMarginsGuide.trailingAnchor)
    
    let bottom = safeAreaLayoutGuide.bottomAnchor
      .constraint(equalTo: buttonStackView.bottomAnchor, constant: 30)
    
    let height = buttonStackView.heightAnchor
      .constraint(equalToConstant: 50)
    
    NSLayoutConstraint.activate([leading, trailing, bottom, height])
    
  }
  
}
