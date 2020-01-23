//
//  LaunchViewController.swift
//  Login
//
//  Created by Taylor Maxwell on 11/23/19.
//  Copyright © 2019 Taylor Maxwell. All rights reserved.
//

import PromiseKit
import RxSwift
import RxCocoa

/// Generates view model to handle display of associated launch view model
protocol LaunchViewModelFactory {

  /// Returns generated associated view model
  func makeLaunchViewModel() -> LaunchViewModel

}

/// Handles launch screen
class LaunchViewController: BaseViewController {

  // MARK: - Properties

  let viewModel: LaunchViewModel
  let disposeBag = DisposeBag()

  /// Configures with passed view model
  /// - Parameter launchViewModelFactory: Provides the associated view model
  init(launchViewModelFactory: LaunchViewModelFactory) {

    self.viewModel = launchViewModelFactory.makeLaunchViewModel()
    super.init()

  }

  /// Display associated view model's view
  public override func loadView() {

    super.viewDidLoad()
    view = LaunchView(viewModel: viewModel)

  }

}
