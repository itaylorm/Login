//
//  SignUpView.swift
//  Login
//
//  Created by Taylor Maxwell on 11/24/19.
//  Copyright © 2019 Taylor Maxwell. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

/// Handles appearance of sign up UI
class SignUpView: BaseView {
  
  // MARK: Properties
  
  let viewModel: SignUpViewModel
  let disposeBag = DisposeBag()
  
  var hierarchyNotReady = true
  
  // The dynamic constraints for controls that
  // change based upon orientation
  var bottomViewHeightConstraint: NSLayoutConstraint?
  var inputStackTopConstraint: NSLayoutConstraint?
  
  // MARK: Controls
  
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
  
  let scrollView: UIScrollView = {
    let scroll = UIScrollView()
    scroll.alwaysBounceVertical = true
    scroll.showsVerticalScrollIndicator = false
    scroll.showsHorizontalScrollIndicator = false
    scroll.autoresizingMask = UIView.AutoresizingMask.flexibleHeight
    scroll.translatesAutoresizingMaskIntoConstraints = false
    return scroll
  }()
  
  let contentView: UIView = {
    let content = UIView()
    content.translatesAutoresizingMaskIntoConstraints = false
    return content
  }()
  
  let appLogoImageView: UIImageView = {
  
    let imageView = UIImageView(image: UIImage(named: "SignUp"))
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFit
    return imageView
    
  }()
  
  lazy var inputStack: UIStackView = {
    let stack = UIStackView(arrangedSubviews: [
      fullNameInputStack,
      nicknameInputStack,
      emailInputStack,
      mobileNumberInputStack,
      passwordInputStack
    ])
    stack.axis = .vertical
    stack.spacing = 10
    stack.translatesAutoresizingMaskIntoConstraints = false
    return stack
  }()

  lazy var fullNameInputStack: UIStackView = {
    let stack = UIStackView(arrangedSubviews: [fullNameIcon, fullNameField])
    stack.axis = .horizontal
    return stack
  }()

  let fullNameIcon: UIImageView = {
    let imageView = UIImageView()
    imageView.heightAnchor
      .constraint(equalToConstant: 40)
      .isActive = true
    imageView.widthAnchor
      .constraint(equalToConstant: 40)
      .isActive = true
    imageView.image = UIImage(named:"person_icon")?.withRenderingMode(.alwaysTemplate)
    imageView.contentMode = .center
    return imageView
  }()

  let fullNameField: UITextField = {
    let field = UITextField()
    field.placeholder = "Full Name"
    field.autocorrectionType = .no
    field.autocapitalizationType = .words
    return field
  }()

  lazy var nicknameInputStack: UIStackView = {
    let stack = UIStackView(arrangedSubviews: [nicknameIcon, nicknameField])
    stack.axis = .horizontal
    return stack
  }()

  let nicknameIcon: UIImageView = {
    let imageView = UIImageView()
    imageView.heightAnchor
      .constraint(equalToConstant: 40)
      .isActive = true
    imageView.widthAnchor
      .constraint(equalToConstant: 40)
      .isActive = true
    imageView.image = UIImage(named:"tag_icon")?.withRenderingMode(.alwaysTemplate)
    imageView.contentMode = .center
    return imageView
  }()

  let nicknameField: UITextField = {
    let field = UITextField()
    field.placeholder = "What should we call you?"
    field.autocorrectionType = .no
    field.autocapitalizationType = .words
    return field
  }()

  lazy var emailInputStack: UIStackView = {
    let stack = UIStackView(arrangedSubviews: [emailIcon, emailField])
    stack.axis = .horizontal
    return stack
  }()

  let emailIcon: UIImageView = {
    let imageView = UIImageView()
    imageView.heightAnchor
      .constraint(equalToConstant: 40)
      .isActive = true
    imageView.widthAnchor
      .constraint(equalToConstant: 40)
      .isActive = true
    imageView.image = UIImage(named:"email_icon")?.withRenderingMode(.alwaysTemplate)
    imageView.contentMode = .center
    return imageView
  }()

  let emailField: UITextField = {
    let field = UITextField()
    field.placeholder = "Email"
    field.keyboardType = .emailAddress
    field.autocapitalizationType = .none
    field.autocorrectionType = .no
    return field
  }()

  lazy var mobileNumberInputStack: UIStackView = {
    let stack = UIStackView(arrangedSubviews: [mobileNumberIcon, mobileNumberField])
    stack.axis = .horizontal
    return stack
  }()

  let mobileNumberIcon: UIImageView = {
    let imageView = UIImageView()
    imageView.heightAnchor
      .constraint(equalToConstant: 40)
      .isActive = true
    imageView.widthAnchor
      .constraint(equalToConstant: 40)
      .isActive = true
    imageView.image = UIImage(named:"mobile_icon")?.withRenderingMode(.alwaysTemplate)
    imageView.contentMode = .center
    return imageView
  }()

  let mobileNumberField: UITextField = {
    let field = UITextField()
    field.placeholder = "Mobile Number"
    field.keyboardType = .phonePad
    field.autocapitalizationType = .none
    field.autocorrectionType = .no
    return field
  }()

  lazy var passwordInputStack: UIStackView = {
    let stack = UIStackView(arrangedSubviews: [passwordIcon, passwordField])
    stack.axis = .horizontal
    return stack
  }()

  let passwordIcon: UIImageView = {
    let imageView = UIImageView()
    imageView.heightAnchor
      .constraint(equalToConstant: 40)
      .isActive = true
    imageView.widthAnchor
      .constraint(equalToConstant: 40)
      .isActive = true
    imageView.image = UIImage(named:"password_icon")?.withRenderingMode(.alwaysTemplate)
    imageView.contentMode = .center
    return imageView
  }()

  let passwordField: UITextField = {
    let field = UITextField()
    field.placeholder = "Password"
    field.isSecureTextEntry = true
    return field
  }()

  let signUpButton: UIButton = {
    
    let button = UIButton(type: .custom)
    button.setTitle("Sign Up", for: .normal)
    button.titleLabel?.font = Button.font
    button.layer.borderWidth = Button.borderWidth
    button.layer.cornerRadius = Button.cornerRadius
    button.layer.backgroundColor = Button.backgroundColor
    button.translatesAutoresizingMaskIntoConstraints = false
    button.heightAnchor.constraint(equalToConstant: Button.height).isActive = true
    button.widthAnchor.constraint(equalToConstant: Button.width).isActive = true
    return button
    
  }()
  
  // MARK: Methods
  
  /// Configures view
  /// - Parameters:
  ///   - frame: Bounds of the view
  ///   - viewModel: Associated view model
  init(frame: CGRect = .zero, viewModel: SignUpViewModel) {
    
    self.viewModel = viewModel
    super.init(frame: frame)
    
  }

  deinit {
    NotificationCenter.default.removeObserver(self,
      name: UIDevice.orientationDidChangeNotification, object: nil)
  }
  
  /// Handles any actions associated with rotating
  @objc func rotated() {
    configureTopView()
    configureBottomViewHeightContraint()
    configureInputStackTopContraint()
  }
  
  /// Triggers when window appears
  override func didMoveToWindow() {
    super.didMoveToWindow()
    guard hierarchyNotReady else {
      return
    }
    
    NotificationCenter.default.addObserver(self, selector: #selector(self.rotated),
          name: UIDevice.orientationDidChangeNotification, object: nil)
    
    formatTextFields()
    constructHierarchy()

    activateConstraints()
    wireController()

    hierarchyNotReady = false
    
  }

  /// Add controls to their containers
  func constructHierarchy() {
    
    contentView.addSubview(topView)
    topView.addSubview(appLogoImageView)
    
    bottomView.addSubview(inputStack)
    bottomView.addSubview(signUpButton)
    
    contentView.addSubview(bottomView)
    scrollView.addSubview(contentView)
    addSubview(scrollView)
  
  }

  /// Trigger sign up when user clicks sign up button
  private func wireController() {
    signUpButton.addTarget(self, action: #selector(signUp), for: .touchUpInside)
  }

  /// Sign up handler
  @objc func signUp() {
    endEditing(true)
    viewModel.signUp()
  }
  
  /// Configure text fields with bottom lines
  private func formatTextFields() {
    
    fullNameField.format()
    nicknameField.format()
    emailField.format()
    mobileNumberField.format()
    passwordField.format()
    
  }

}

/// Constraints
extension SignUpView {
  
  // Position controls on the screen
  fileprivate func activateConstraints() {
  
    activateConstraintsScrollView()
    activateConstraintsContentView()
    activateContraintsTopView()
    activateConstraintsAppLogo()
    activateContraintsBottomView()
    activateConstraintsInputStack()
    activateConstraintsSignUpButton()
  
  }
  
  /// Configure scroll position
  func activateConstraintsScrollView() {

    let leading = scrollView.leadingAnchor
      .constraint(equalTo: layoutMarginsGuide.leadingAnchor)
    let trailing = scrollView.trailingAnchor
      .constraint(equalTo: layoutMarginsGuide.trailingAnchor)
    let top = scrollView.topAnchor
      .constraint(equalTo: safeAreaLayoutGuide.topAnchor)
    let bottom = scrollView.bottomAnchor
      .constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
    NSLayoutConstraint.activate(
      [leading, trailing, top, bottom])
  }
  
  /// Configure container view position
  func activateConstraintsContentView() {
    
    let width = contentView.widthAnchor
      .constraint(equalTo: scrollView.widthAnchor)
    let leading = contentView.leadingAnchor
      .constraint(equalTo: scrollView.leadingAnchor)
    let trailing = contentView.trailingAnchor
      .constraint(equalTo: scrollView.trailingAnchor)
    let top = contentView.topAnchor
      .constraint(equalTo: scrollView.topAnchor)
    let bottom = contentView.bottomAnchor
      .constraint(equalTo: scrollView.bottomAnchor)
    NSLayoutConstraint.activate(
      [width, leading, trailing, top, bottom])
  }
  
  /// Configure the top container to fill top of screen
  func activateContraintsTopView() {
  
    let top = topView.topAnchor.constraint(equalTo: contentView.topAnchor)
    let height = topView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5)
    let left = topView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
    let right = topView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
    NSLayoutConstraint.activate([top, height, left, right])
  
  }
  
  /// Makes the top graphic visible or invisible
  /// Visible on portrait, invisible on landscape
  func configureTopView() {
    
    if UIDevice.current.orientation.isPortrait {
      topView.isHidden = false
      appLogoImageView.isHidden = false
    } else {
      topView.isHidden = true
      appLogoImageView.isHidden = true
    }
  }
  /// Apply logo constraints to position on screen
  func activateConstraintsAppLogo() {
    
    configureTopView()
    
    let top = appLogoImageView.topAnchor.constraint(equalTo: topView.topAnchor, constant: 10)
    let centerX = appLogoImageView.centerXAnchor.constraint(equalTo: topView.centerXAnchor)
    let height = appLogoImageView.heightAnchor.constraint(equalTo: topView.heightAnchor, multiplier: 0.8)
    let width = appLogoImageView.widthAnchor.constraint(equalTo: topView.widthAnchor, multiplier: 0.8)
    NSLayoutConstraint.activate([top, centerX, height, width])
    
  }
  
  /// Handles the appropriate bottom view setting upon rotate
  func configureBottomViewHeightContraint() {
    
    if bottomViewHeightConstraint != nil {
      bottomViewHeightConstraint?.isActive = false
      bottomViewHeightConstraint = nil
    }
    
    var height: NSLayoutConstraint
    if UIDevice.current.orientation.isPortrait {
      height = bottomView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5)
    } else {
      height = bottomView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 1.0)
    }
    
    height.isActive = true
    bottomViewHeightConstraint = height
    
  }
  
  /// Configure the bottom container to fill bottom of screen
  func activateContraintsBottomView() {
  
    configureBottomViewHeightContraint()
    let bottom = bottomView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
    let left = bottomView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
    let right = bottomView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
    NSLayoutConstraint.activate([bottom, left, right])
  
  }
  
  /// Handles the appropriate bottom view setting upon rotate
  func configureInputStackTopContraint() {
    
    if inputStackTopConstraint != nil {
      inputStackTopConstraint?.isActive = false
      inputStackTopConstraint = nil
    }
    
    var top: NSLayoutConstraint
    if UIDevice.current.orientation.isPortrait {
      top = inputStack.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 0)
    } else {
      top = inputStack.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 20)
    }
    
    top.isActive = true
    inputStackTopConstraint = top
    
  }
  
  /// Configure the data entry stack container position
  func activateConstraintsInputStack() {
    
    configureInputStackTopContraint()
    
    let leading = inputStack.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor)
    let trailing = inputStack.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor)

    NSLayoutConstraint.activate([leading, trailing])
    
  }

  /// Position sign up button
  func activateConstraintsSignUpButton() {
    
    let centerX = signUpButton.centerXAnchor.constraint(equalTo: inputStack.centerXAnchor)
    let top = signUpButton.topAnchor
      .constraint(equalTo: inputStack.bottomAnchor, constant: 20)
    let bottom = contentView.bottomAnchor
      .constraint(equalTo: signUpButton.bottomAnchor, constant: 20)
    NSLayoutConstraint.activate([centerX, top, bottom])
    
  }
  
}
/// Binding fields
extension SignUpView {
  
  /// Configure fields with view model
  func bindFieldsToViewModel() {
    bindFullNameField()
    bindNicknameField()
    bindEmailField()
    bindMobileNumberField()
    bindPasswordField()
  }

  /// Configure full name with view model
  func bindFullNameField() {
    fullNameField.rx.text
      .asDriver()
      .map { $0 ?? "" }
      .drive(viewModel.nameInput)
      .disposed(by: disposeBag)
  }

  /// Configure nickname with view model
  func bindNicknameField() {
    nicknameField.rx.text
      .asDriver()
      .map { $0 ?? "" }
      .drive(viewModel.nicknameInput)
      .disposed(by: disposeBag)
  }

  /// Configure email with view model
  func bindEmailField() {
    emailField.rx.text
      .asDriver()
      .map { $0 ?? "" }
      .drive(viewModel.emailInput)
      .disposed(by: disposeBag)
  }

  /// Configure mobile number with view model
  func bindMobileNumberField() {
    mobileNumberField.rx.text
      .asDriver()
      .map { $0 ?? "" }
      .drive(viewModel.mobileNumberInput)
      .disposed(by: disposeBag)
  }

  /// Configure password with view model
  func bindPasswordField() {
    passwordField.rx.text
      .asDriver()
      .map { $0 ?? "" }
      .drive(viewModel.passwordInput)
      .disposed(by: disposeBag)
  }
  
}

/// Scrolling methods
extension SignUpView {
  
  /// Trigger layout of content when scrolls
  func configureViewAfterLayout() {
    resetScrollViewContentInset()
  }
  
  /// Scroll
  private func resetScrollViewContentInset() {
    
    scrollView.contentOffset = CGPoint(x: 0, y: 0)
    scrollView.contentSize = CGSize(width: contentView.frame.width, height: contentView.frame.height * 1.5)
    
  }
  
  /// Scroll
  func moveContentForDismissedKeyboard() {
    resetScrollViewContentInset()
  }
  
  /// Ensure that data entry controls are visible when scrolling
  func moveContent(forKeyboardFrame keyboardFrame: CGRect) {
    
    var insets = scrollView.contentInset
    insets.bottom = keyboardFrame.height
    scrollView.contentInset = insets
    
  }
  
}
