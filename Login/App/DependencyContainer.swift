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
class DependencyContainer {
  
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
    return MainViewController(mainViewModel: mainViewModel, launchViewController: launchViewController)
    
  }
  
  /// Configures the launch controller
  func makeLaunchViewController() -> LaunchViewController {
      return LaunchViewController(launchViewModelFactory: self)
  }
  
}

/// Implements the methods associated with creating launch view information
extension DependencyContainer: LaunchViewModelFactory {
  
  /// Returns generated associated view model
  func makeLaunchViewModel() -> LaunchViewModel {
    return LaunchViewModel(userSessionRepository: userSessionRepository,
                           notSignedInResponder: mainViewModel,
                           signedInResponder: mainViewModel)
  }
}
