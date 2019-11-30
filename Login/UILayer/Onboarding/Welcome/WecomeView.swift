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
  
  // MARK: Properties
  
  let viewModel: WelcomeViewModel
  
  // Used to make sure that the controls are full displayed
  // in the didMoveToWindow. If not tries again
  var hierarchyNotReady = true
  
  // The dynamic constraints for controls that
  // change based upon orientation
  var signInTopConstraint: NSLayoutConstraint?
  var signUpTopConstraint: NSLayoutConstraint?
  var passwordTopConstraint: NSLayoutConstraint?
  var emailTopConstraint: NSLayoutConstraint?
  
  // MARK: Controls
  
  let contentView: UIView = {
    let content = UIView()
    content.translatesAutoresizingMaskIntoConstraints = false
    return content
  }()
  
  let scrollView: UIScrollView = {
    let scroll = UIScrollView()
    scroll.alwaysBounceVertical = true
    scroll.autoresizingMask = UIView.AutoresizingMask.flexibleHeight
    scroll.translatesAutoresizingMaskIntoConstraints = false
    return scroll
  }()
  

  
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

  let emailField: UITextField = {
    let field = UITextField()
    field.placeholder = "Email"
    field.keyboardType = .emailAddress
    field.autocapitalizationType = .none
    field.autocorrectionType = .no
    field.translatesAutoresizingMaskIntoConstraints = false
    return field
  }()
  
  let passwordField: UITextField = {
    let field = UITextField()
    field.placeholder = "Password"
    field.isSecureTextEntry = true
    field.translatesAutoresizingMaskIntoConstraints = false
    return field
  }()
  
  let signInButton: UIButton = {
    
    let button = UIButton(type: .custom)
    button.setTitle("Sign In", for: .normal)
    button.titleLabel?.font = Button.font
    button.layer.borderWidth = Button.borderWidth
    button.layer.cornerRadius = Button.cornerRadius
    button.layer.backgroundColor = Button.backgroundColor
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
    
  }()

  let signUpButton: UIButton = {
    
    let button = UIButton(type: .custom)
    button.setTitle("Sign Up?", for: .normal)
    button.setTitleColor(Color.primary, for: .normal)
    button.titleLabel?.font = Button.font
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
    
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
  
  deinit {
    NotificationCenter.default.removeObserver(self,
      name: UIDevice.orientationDidChangeNotification, object: nil)
  }
  
  /// Handles any actions associated with rotating
  @objc func rotated() {
    configureSignInTopContraint()
    configureSignUpTopContraint()
    configureEmailTopContraint()
    configurePasswordTopContraint()
  }
  
  /// Triggers when window becomes available
  override func didMoveToWindow() {
    
    super.didMoveToWindow()
    
    guard hierarchyNotReady else { return }
    
    NotificationCenter.default.addObserver(self, selector: #selector(self.rotated),
          name: UIDevice.orientationDidChangeNotification, object: nil)
    
    constructHierarchy()
    formatTextFields()
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
  /// Scroll help: https://www.appcoda.com/uiscrollview-introduction/
  func constructHierarchy() {
    
    contentView.addSubview(topView)
    topView.addSubview(appLogoImageView)

    bottomView.addSubview(emailField)
    bottomView.addSubview(passwordField)
    bottomView.addSubview(signInButton)
    bottomView.addSubview(signUpButton)

    contentView.addSubview(bottomView)
    scrollView.addSubview(contentView)
    addSubview(scrollView)
    
  }

  /// Configure text fields with bottom lines
  private func formatTextFields() {
  
    emailField.format()
    passwordField.format()
  
  }
  
  /// Apply control constraints
  func activateConstraints() {
    
    activateConstraintsScrollView()
    activateConstraintsContentView()
    activateContraintsTopView()
    activateConstraintsAppLogo()
    activateContraintsBottomView()
    activateConstraintsEmail()
    activateConstraintsPassword()
    activateConstraintsSignIn()
    activateConstraintsSignUp()
    
  }

  /// Configure scroll position
  func activateConstraintsScrollView() {
    
    let leading = scrollView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor)
    let trailing = scrollView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor)
    let top = scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor)
    let bottom = scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
    NSLayoutConstraint.activate([leading, trailing, top, bottom])
    
  }
  
  /// Configure scroll to reveal hidden content behind keyboard
  func configureViewAfterLayout() {
    resetScrollViewContentInset()
  }
  
  /// Ensures that a scroll will reveal hidden controls or content
  private func resetScrollViewContentInset() {
    
    scrollView.contentOffset = CGPoint(x: 0, y: 0)
    scrollView.contentSize = CGSize(width: contentView.frame.width, height: contentView.frame.height * 1.5)

  }
  
  /// Configure container view position
  func activateConstraintsContentView() {
    
    let height = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
    let width = contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
    let leading = contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor)
    let trailing = contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor)
    NSLayoutConstraint.activate([height, width, leading, trailing])
    
  }
  
  /// Configure the top container to fill top of screen
  func activateContraintsTopView() {
  
    let top = topView.topAnchor.constraint(equalTo: contentView.topAnchor)
    let height = topView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5)
    let left = topView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
    let right = topView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
    NSLayoutConstraint.activate([top, height, left, right])
  
  }
  
  /// Configure the bottom container to fill bottom of screen
  func activateContraintsBottomView() {
  
    let bottom = bottomView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
    let height = bottomView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5)
    let left = bottomView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
    let right = bottomView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
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

  /// Apply email constraints to position on screen
  func activateConstraintsEmail() {
    
    configureEmailTopContraint()
    
    let centerX = emailField.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor)
    let height = emailField.heightAnchor.constraint(equalToConstant: 30)
    let width = emailField.widthAnchor.constraint(equalTo: bottomView.widthAnchor, multiplier: 0.8)
    NSLayoutConstraint.activate([centerX, height, width])
    
  }
  
  /// Handles the appropriate password setting upon rotate
  func configureEmailTopContraint() {
    
    if emailTopConstraint != nil {
      emailTopConstraint?.isActive = false
      emailTopConstraint = nil
    }
    
    var top: NSLayoutConstraint
    if UIDevice.current.orientation.isPortrait {
      top = emailField.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 10)
    } else {
      top = emailField.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 0)
    }
    
    top.isActive = true
    emailTopConstraint = top
    
  }
  
  /// Apply password constraints to position on screen
  func activateConstraintsPassword() {
    
    configurePasswordTopContraint()
          
    let centerX = passwordField.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor)
    let height = passwordField.heightAnchor.constraint(equalToConstant: 30)
    let width = passwordField.widthAnchor.constraint(equalTo: bottomView.widthAnchor, multiplier: 0.8)
    NSLayoutConstraint.activate([centerX, height, width])
    
  }
  
  /// Handles the appropriate password setting upon rotate
  func configurePasswordTopContraint() {
    
    if passwordTopConstraint != nil {
      passwordTopConstraint?.isActive = false
      passwordTopConstraint = nil
    }
    
    var top: NSLayoutConstraint
    if UIDevice.current.orientation.isPortrait {
      top = passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 30)
    } else {
      top = passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 10)
    }
    top.isActive = true
    passwordTopConstraint = top
    
  }
  
  /// Apply sign in button constraints to position on screen
  func activateConstraintsSignIn() {

    configureSignInTopContraint()
    
    let centerX = signInButton.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor)
    let height = signInButton.heightAnchor.constraint(equalToConstant: Button.height)
    let width = signInButton.widthAnchor.constraint(equalToConstant: Button.width)
    NSLayoutConstraint.activate([centerX, height, width])
    
  }
  
  /// Handles the appropriate setting upon rotate
  func configureSignInTopContraint() {
    
    if signInTopConstraint != nil {
      signInTopConstraint?.isActive = false
      signInTopConstraint = nil
    }
    
    var top: NSLayoutConstraint
    if UIDevice.current.orientation.isPortrait {
      top = signInButton.bottomAnchor.constraint(equalTo: signUpButton.topAnchor, constant: -10)
    } else {
      top = signInButton.bottomAnchor.constraint(equalTo: signUpButton.topAnchor, constant: 0)
    }
    top.isActive = true
    signInTopConstraint = top
    
  }
  
  /// Apply sign up button constraints to position on screen
  func activateConstraintsSignUp() {
    
    configureSignUpTopContraint()

    let centerX = signUpButton.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor)
    let height = signUpButton.heightAnchor.constraint(equalToConstant: Button.height)
    NSLayoutConstraint.activate([centerX, height])
    
  }
  
  /// Handles the appropriate top setting upon rotate
  func configureSignUpTopContraint() {
    
    if signUpTopConstraint != nil {
      signUpTopConstraint?.isActive = false
      signUpTopConstraint = nil
    }
    
    var top: NSLayoutConstraint
    if UIDevice.current.orientation.isPortrait {
      top = signUpButton.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: -10)
    } else {
      top = signUpButton.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: 0)
    }
    top.isActive = true
    signUpTopConstraint = top
    
  }
  
}
