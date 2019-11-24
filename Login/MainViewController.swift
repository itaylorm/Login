//
//  MainViewController.swift
//  Login
//
//  Created by Taylor Maxwell on 11/23/19.
//  Copyright © 2019 Taylor Maxwell. All rights reserved.
//

import UIKit
import RxSwift

/// Main entry point for the application
class MainViewController: BaseViewController {

  // Mark: Properties
  
  let viewModel: MainViewModel
  
  let launchViewController: LaunchViewController
  
  let disposeBag = DisposeBag()
  
  // MARK: Methods
  
  /// Initializer that takes the startup controllers and presents the appropriate
  /// screen based upon current state of the application
  /// - Parameters:
  ///   - mainViewModel: Contains the state of the application and drives which screen to display
  ///   - launchViewController: Initial display
  init(mainViewModel: MainViewModel, launchViewController: LaunchViewController) {
  
    self.viewModel = mainViewModel
    
    self.launchViewController = launchViewController
    
    super.init()
    
  }

  /// Triggers when view is first loaded
  /// Configures appropriate associated view
  override func viewDidLoad() {
    super.viewDidLoad()
    
    observeViewModel()
    
  }
  
  /// Configures associated main view
  private func observeViewModel() {
    
    let observable = viewModel.view.distinctUntilChanged()
    subscribe(to: observable)
    
  }
  
  /// Provides means to recieve changes to the MainView and
  /// information about the current state of the application
  /// - Parameter observable: <#observable description#>
  func subscribe(to observable: Observable<MainView>) {
    
    observable
      .subscribe(onNext: { [weak self] view in
        guard let strongSelf = self else { return }
        strongSelf.present(view)
      })
    .disposed(by: disposeBag)
  }
  
  /// Displays the appropriate screen based upon current state of the application
  /// - Parameter view: Reference to main view containing state of application
  func present(_ view: MainView) {
  
    switch view {
      case .launching: presentLaunching()
      case .onboarding: presentOnBoarding()
      case .signedIn(let userSession): presentSignedIn(userSession: userSession)
    }
    
  }
  
  /// Display launch screen
  func presentLaunching() {
    addFullScreen(childViewController: launchViewController)
  }
  
  /// <#Description#>
  func presentOnBoarding() {
    
  }
  
  /// <#Description#>
  /// - Parameter userSession: <#userSession description#>
  func presentSignedIn(userSession: UserSession) {
    
  }
  
}
