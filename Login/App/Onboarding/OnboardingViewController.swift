//
//  OnboardingViewController.swift
//  Login
//
//  Created by Taylor Maxwell on 11/24/19.
//  Copyright © 2019 Taylor Maxwell. All rights reserved.
//

import Foundation
import RxSwift

/// Handle the process of signing up or signing in the user
/// The actual sign in and sign up processes are handled
/// by other controller, this controllers handles taking user to the appropriate
/// screen based upon need (New user or existing user)
class OnboardingViewController: BaseNavigationController {
  
  // MARK: Properties
  
  let viewModel: OnboardingViewModel
  let disposeBag = DisposeBag()
  
  // Child View Controllers
  let welcomeViewController: WelcomeViewController
  let signInViewController: SignInViewController
  let signUpViewController: SignUpViewController
  
  // MARK: Methods
  
  /// Configures to handing onboarding with passed controllers to
  /// handle the different conditions of signing up or signing in a user
  /// - Parameters:
  ///   - viewModel: Associated type for handling displaying appropriate UI
  ///   - welcomeViewController: Handles welcoming user to system and allowing to pick sign in or sign up
  ///   - signInViewController: Handles the sign in process
  ///   - signUpViewController: Handles the sign up process
  init(viewModel: OnboardingViewModel,
       welcomeViewController: WelcomeViewController,
       signInViewController: SignInViewController,
       signUpViewController: SignUpViewController) {
    
    self.viewModel = viewModel
    self.welcomeViewController = welcomeViewController
    self.signInViewController = signInViewController
    self.signUpViewController = signUpViewController
    
    super.init()
    
    self.delegate = self
    
  }
  
  /// This actually displays the view display
  public override func viewDidLoad() {
    
    super.viewDidLoad()
    subscribe(to: viewModel.view)
    
  }

  /// Provides a means to respond to changes to onboard state
  /// - Parameter observable: Observes changes to action
  func subscribe(to observable: Observable<OnboardingNavigationAction>) {
    observable
      .distinctUntilChanged()
      .subscribe(onNext: { [weak self] action in
        guard let strongSelf = self else { return }
        strongSelf.respond(to: action)
      }).disposed(by: disposeBag)
  }

  /// Handle navigation request by seeing appropriate enum setting
  /// - Parameter navigationAction: Action to take
  func respond(to navigationAction: OnboardingNavigationAction) {
    switch navigationAction {
    case .present(let state):
      present(state: state)
    case .presented:
      break
    }
  }

  /// Triggers the display of appropriate view
  /// - Parameter state: onboarding state
  func present(state: OnboardingState) {
    switch state {
    case .welcome:
      presentWelcome()
    case .signin:
      presentSignIn()
    case .signup:
      presentSignUp()
    }
  }

  /// Display welcome
  func presentWelcome() {
    pushViewController(welcomeViewController, animated: false)
  }

  // Display sign in
  func presentSignIn() {
    pushViewController(signInViewController, animated: true)
  }

  // Display sign up
  func presentSignUp() {
    pushViewController(signUpViewController, animated: true)
  }
}

// Handles navigation bar
extension OnboardingViewController {

  /// Determines whether to display navigation bar
  /// - Parameters:
  ///   - view: associated view reference
  ///   - animated: animation flag
  func hideOrShowNavigationBarIfNeeded(for state: OnboardingState, animated: Bool) {
    if state.hidesNavigationBar() {
      hideNavigationBar(animated: animated)
    } else {
      showNavigationBar(animated: animated)
    }
  }

  /// Hides navigtaion bar
  /// - Parameter animated: Animation flag
  func hideNavigationBar(animated: Bool) {
    if animated {
      transitionCoordinator?.animate(alongsideTransition: { context in
        self.setNavigationBarHidden(true, animated: animated)
      })
    } else {
      setNavigationBarHidden(true, animated: false)
    }
  }

  /// Display navigation bar
  /// - Parameter animated: animation flag
  func showNavigationBar(animated: Bool) {
    if self.isNavigationBarHidden {
      self.setNavigationBarHidden(false, animated: animated)
    }
  }
}

/// Handles navigation between onboarding controllers
extension OnboardingViewController: UINavigationControllerDelegate {

  /// Handles view changes that happen before shown to user
  /// - Parameters:
  ///   - navigationController: Reference to navigation controller
  ///   - viewController: Reference to view controller being shown
  ///   - animated: Animation flag
  func navigationController(_ navigationController: UINavigationController,
                                   willShow viewController: UIViewController,
                                   animated: Bool) {
    
    guard let viewToBeShown = onboardingView(associatedWith: viewController) else { return }
    hideOrShowNavigationBarIfNeeded(for: viewToBeShown, animated: animated)
  
  }

  /// Handles display changes that happened when shown to user
  /// - Parameters:
  ///   - navigationController: Reference to navigation controller
  ///   - viewController: Reference to view controller being shown
  ///   - animated: Animation flag
  func navigationController(_ navigationController: UINavigationController,
                                   didShow viewController: UIViewController,
                                   animated: Bool) {
    
    guard let shownView = onboardingView(associatedWith: viewController) else { return }
    viewModel.uiPresented(onboarding: shownView)
    
  }
  
  /// Uses the onboarding enum to determine which controller view  is to be displayed
  /// - Parameter viewController: View Controller currently be called
  func onboardingView(associatedWith viewController: UIViewController) -> OnboardingState? {
    switch viewController {
    case is WelcomeViewController:
      return .welcome
    case is SignInViewController:
      return .signin
    case is SignUpViewController:
      return .signup
    default:
      assertionFailure("Encountered unexpected child view controller type in OnboardingViewController")
      return nil
    }
  }
  
}

