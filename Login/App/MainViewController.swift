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
  
  // Child Controllers
  let launchViewController: LaunchViewController
  var onboardingViewController: OnboardingViewController?
  var signedInViewController: SignedInViewController?
  
  let disposeBag = DisposeBag()
  
  // Factories
  let makeOnboardingViewController: () -> OnboardingViewController
  //let makeSignedInViewController: (UserSession) -> SignedInViewController
  
  // MARK: Methods
  
  /// Initializer that takes the startup controllers and presents the appropriate
  /// screen based upon current state of the application
  /// - Parameters:
  ///   - mainViewModel: Contains the state of the application and drives which screen to display
  ///   - launchViewController: Initial display
  ///   - onboardingViewController: Handles on boarding process
  init(mainViewModel: MainViewModel,
       launchViewController: LaunchViewController,
       onboardingViewControllerFactory: @escaping () -> OnboardingViewController) {
  
    self.viewModel = mainViewModel
    
    self.launchViewController = launchViewController
    self.makeOnboardingViewController = onboardingViewControllerFactory
    //self.makeSignedInViewController = signedInViewControllerFactory
    
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
  
  /// Provides means to recieve changes to the MainView enum
  /// Change then triggers a different screen to display
  /// - Parameter observable: Reference to MainView, change triggers different view display
  func subscribe(to observable: Observable<MainState>) {
    
    observable
      .subscribe(onNext: { [weak self] view in
        guard let strongSelf = self else { return }
        strongSelf.present(view)
      })
    .disposed(by: disposeBag)
    
  }
  
  /// Displays the appropriate screen based upon current state of the application
  /// State changes are detected by change to the value of MainView which is an enum
  /// - Parameter view: Reference to main view containing state of application
  func present(_ state: MainState) {
  
    switch state {
      case .launching: presentLaunching()
      case .onboarding: presentOnBoarding()
      case .signedIn(let userSession): presentSignedIn(userSession: userSession)
    }
    
  }
  
  /// Display launch screen
  func presentLaunching() {
    addFullScreen(childViewController: launchViewController)
  }
  
  /// Takes the user to the next step after launch to prompt to see the welcome screen and then to login or sign up
  func presentOnBoarding() {
    
    let onboardingViewController = makeOnboardingViewController()
    
    present(onboardingViewController, animated: true) { [weak self] in
      
      guard let strongSelf = self else {
        return
      }
      
      strongSelf.remove(childViewController: strongSelf.launchViewController)
      
      if let signedInViewController = strongSelf.signedInViewController {
        strongSelf.remove(childViewController: signedInViewController)
        strongSelf.signedInViewController = nil
      }
    }
    
    onboardingViewController.modalPresentationStyle = .fullScreen
    self.onboardingViewController = onboardingViewController
    
  }
  
  /// <#Description#>
  /// - Parameter userSession: <#userSession description#>
  func presentSignedIn(userSession: UserSession) {
    
  }
  
}
