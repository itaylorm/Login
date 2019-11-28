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
  
  let scrollView: UIScrollView = UIScrollView()
  let contentView: UIView = UIView()
  
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
    button.titleLabel?.font = .boldSystemFont(ofSize: 18)
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
    
    //backgroundColor = Color.primary
    
  }
  
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

  /// Triggers when window appears
  override func didMoveToWindow() {
    super.didMoveToWindow()
    guard hierarchyNotReady else {
      return
    }
    
    //backgroundColor = Color.primary
    constructHierarchy()
    activateConstraints()
    wireController()
    hierarchyNotReady = false
  }

  func constructHierarchy() {
    scrollView.addSubview(contentView)
    contentView.addSubview(inputStack)
    contentView.addSubview(signUpButton)
    addSubview(scrollView)
  }

  func activateConstraints() {
    activateConstraintsScrollView()
    activateConstraintsContentView()
    activateConstraintsInputStack()
    activateConstraintsSignUpButton()
  }

  func wireController() {
    signUpButton.addTarget(self, action: #selector(signUp), for: .touchUpInside)
  }

  @objc func signUp() {
    endEditing(true)
    viewModel.signUp()
  }

  func configureViewAfterLayout() {
    resetScrollViewContentInset()
  }
  
  func resetScrollViewContentInset() {
    let scrollViewBounds = scrollView.bounds
    let contentViewHeight = CGFloat(330.0)

    var scrollViewInsets = UIEdgeInsets.zero
    scrollViewInsets.top = scrollViewBounds.size.height / 2.0;
    scrollViewInsets.top -= contentViewHeight / 2.0;

    scrollViewInsets.bottom = scrollViewBounds.size.height / 2.0
    scrollViewInsets.bottom -= contentViewHeight / 2.0

    scrollView.contentInset = scrollViewInsets
  }
  
  func activateConstraintsScrollView() {
    scrollView.translatesAutoresizingMaskIntoConstraints = false
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
  
  func activateConstraintsContentView() {
    contentView.translatesAutoresizingMaskIntoConstraints = false
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
  
  func activateConstraintsInputStack() {
    inputStack.translatesAutoresizingMaskIntoConstraints = false
    let leading = inputStack.leadingAnchor
      .constraint(equalTo: contentView.leadingAnchor)
    let trailing = inputStack.trailingAnchor
      .constraint(equalTo: contentView.trailingAnchor)
    let top = inputStack.topAnchor
      .constraint(equalTo: contentView.topAnchor)
    NSLayoutConstraint.activate(
      [leading, trailing, top])
  }

  func activateConstraintsSignUpButton() {
    signUpButton.translatesAutoresizingMaskIntoConstraints = false
    let leading = signUpButton.leadingAnchor
      .constraint(equalTo: contentView.leadingAnchor)
    let trailing = signUpButton.trailingAnchor
      .constraint(equalTo: contentView.trailingAnchor)
    let top = signUpButton.topAnchor
      .constraint(equalTo: inputStack.bottomAnchor, constant: 20)
    let bottom = contentView.bottomAnchor
      .constraint(equalTo: signUpButton.bottomAnchor, constant: 20)
    let height = signUpButton.heightAnchor
      .constraint(equalToConstant: 50)
    NSLayoutConstraint.activate([leading, trailing, top, bottom, height])
  }
  
  func moveContentForDismissedKeyboard() {
    resetScrollViewContentInset()
  }
  
  func moveContent(forKeyboardFrame keyboardFrame: CGRect) {
    var insets = scrollView.contentInset
    insets.bottom = keyboardFrame.height
    scrollView.contentInset = insets
  }

}
