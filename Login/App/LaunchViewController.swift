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
    view = LaunchView(viewModel: viewModel)
  }
  
  /// Handle displaying error message
  func observeErrorMessages() {
    viewModel
      .errorMessages
      .asDriver { _ in fatalError("Unexpected error from error messages observable.") }
      .drive(onNext: { [weak self] errorMessage in
        guard let strongSelf = self else {
          return
        }
        strongSelf.present(errorMessage: errorMessage,
                           withPresentationState: strongSelf.viewModel.errorPresentation)
      })
      .disposed(by: disposeBag)
  }
}

