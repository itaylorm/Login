//
//  SignUpViewController.swift
//  Login
//
//  Created by Taylor Maxwell on 11/24/19.
//  Copyright © 2019 Taylor Maxwell. All rights reserved.
//

import Foundation
import RxSwift

/// Handles the process of allowing the user to sign up
class SignUpViewController: BaseViewController {

  // MARK: Properties

  let viewModel: SignUpViewModel
  let disposeBag = DisposeBag()

  // MARK: Methods

  /// Initializes controller with associated view model
  /// - Parameter viewModelFactory: Factory for generating associated view model for display sign up
  init(viewModelFactory: SignUpViewModelFactory) {

    self.viewModel = viewModelFactory.makeSignUpViewModel()
    super.init()

  }

  /// Loads associated view
  override func loadView() {

    view = SignUpView(viewModel: viewModel)

  }

  /// Triggers when view is first loaded
  override func viewDidLoad() {

    super.viewDidLoad()
    observeErrorMessages(viewModel: viewModel, disposeBag: disposeBag)

  }

  /// Triggers when view is about to be displayed
  /// - Parameter animated: whether to use animation
  override func viewWillAppear(_ animated: Bool) {

    super.viewWillAppear(animated)
    addKeyboardObservers()

  }

  /// Triggers when view is about to disappear
  /// - Parameter animated: Whether to use animation
  override func viewWillDisappear(_ animated: Bool) {

    super.viewWillDisappear(animated)
    removeKeyboardObservers()

  }

  /// Triggers when sub views appear
  override func viewDidLayoutSubviews() {

    super.viewDidLayoutSubviews()
    (view as? SignUpView)?.configureViewAfterLayout()

  }

}

/// Handles generating welcome view model
protocol SignUpViewModelFactory {

  /// Generates sign up view model for handling displaying sign up
  func makeSignUpViewModel() -> SignUpViewModel

}

/// Configures and handles keyboard  observers
extension SignUpViewController {

  /// Configures the keyboard handler logic
  func addKeyboardObservers() {

    let notificationCenter = NotificationCenter.default

    notificationCenter.addObserver(self, selector: #selector(handleContentUnderKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)

    notificationCenter.addObserver(self, selector: #selector(handleContentUnderKeyboard),
                                   name: UIResponder.keyboardWillChangeFrameNotification, object: nil)

  }

  /// Ensures that keyboard observers are turned off
  func removeKeyboardObservers() {

    let notificationCenter = NotificationCenter.default
    notificationCenter.removeObserver(self)

  }

  /// Moves content based upon the appearance or disappearance of keyboard
  /// - Parameter notification: Kind of keyboard notification
  @objc func handleContentUnderKeyboard(notification: Notification) {

    if let userInfo = notification.userInfo {

        if let keyboardEndFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {

          let convertedKeyboardEndFrame = view.convert(keyboardEndFrame.cgRectValue, from: view.window)

          if notification.name == UIResponder.keyboardWillHideNotification {
            (view as? SignUpView)?.moveContentForDismissedKeyboard()
          } else {
            (view as? SignUpView)?.moveContent(forKeyboardFrame: convertedKeyboardEndFrame)
          }
      }

    }

  }

}
