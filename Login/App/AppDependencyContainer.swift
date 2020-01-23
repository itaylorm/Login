//
//  AddDependencyContainer.swift
//  Login
//
//  Created by Taylor Maxwell on 11/23/19.
//  Copyright © 2019 Taylor Maxwell. All rights reserved.
//

import Foundation

/// Provides the ability to create the different parts of the app
/// without creating concrete dependencies
class AppDependencyContainer {

  // MARK: Properties

  let userSessionRepository: UserSessionRepository
  let mainViewModel = MainViewModel()

  // MARK: Methods

  /// Default initializer which configures the startup dependencies
  init() {

    let coder = UserSessionPropertyListCoder()
    let dataStore = KeychainUserSessionDataStore(userSessionCoder: coder)
    let authRemoteAPI = AuthRemoteAPIFake()
    userSessionRepository = AppUserSessionRepository(dataStore: dataStore, remoteAPI: authRemoteAPI)

  }

  /// Assembles and returns reference to main controller
  func makeMainViewController() -> MainViewController {

    let launchViewController = makeLaunchViewController()

    let onboardingViewControllerFactory = {
      return self.makeOnboardingViewController()
    }

    return MainViewController(mainViewModel: mainViewModel,
                              launchViewController: launchViewController,
                              onboardingViewControllerFactory: onboardingViewControllerFactory)

  }

  /// Configures the launch controller
  func makeLaunchViewController() -> LaunchViewController {
      return LaunchViewController(launchViewModelFactory: self)
  }

  /// Configures the on board controller along with dependencies
  func makeOnboardingViewController() -> OnboardingViewController {

    let dependencyContainer = OnboardingDependencyContainer(appDependencyContainer: self)
    return dependencyContainer.makeOnboardingViewController()

  }

}

/// Implements the methods associated with creating launch view information
extension AppDependencyContainer: LaunchViewModelFactory {

  /// Returns generated associated view model
  func makeLaunchViewModel() -> LaunchViewModel {
    return LaunchViewModel(userSessionRepository: userSessionRepository,
                           notSignedInResponder: mainViewModel,
                           signedInResponder: mainViewModel)
  }
}
