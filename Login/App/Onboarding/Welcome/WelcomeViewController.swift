//
//  WelcomeViewController.swift
//  Login
//
//  Created by Taylor Maxwell on 11/24/19.
//  Copyright © 2019 Taylor Maxwell. All rights reserved.
//

import Foundation

/// Handles the process of allowing the user to login or sign up
class WelcomeViewController: BaseViewController {

  // MARK: Properties

  let welcomeViewModelFactory: WelcomeViewModelFactory

  // MARK: Methods

  /// Initializes controller with associated view model
  /// - Parameter welcomeViewModelFactory: Provides view model for display welcome
  init(welcomeViewModelFactory: WelcomeViewModelFactory) {

    self.welcomeViewModelFactory = welcomeViewModelFactory

    super.init()

  }

  /// Loads associated view
  public override func loadView() {

    super.loadView()

    let viewModel = welcomeViewModelFactory.makeWelcomeViewModel()
    view = WelcomeView(viewModel: viewModel)

  }

  /// Triggers when sub views appear
  override func viewDidLayoutSubviews() {

    super.viewDidLayoutSubviews()
    (view as? WelcomeView)?.configureViewAfterLayout()

  }
}

/// Handles generating welcome view model
protocol WelcomeViewModelFactory {

  /// Generates welcome view model for handling displaying welcome
  func makeWelcomeViewModel() -> WelcomeViewModel

}
