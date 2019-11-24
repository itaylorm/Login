//
//  iMaxwellViewController.swift
//  Login
//
//  Created by Taylor Maxwell on 11/23/19.
//  Copyright © 2019 Taylor Maxwell. All rights reserved.
//

import UIKit
import RxSwift

/// Root level controller for all view controllers designed to use initializer dependency
/// injection  instead of a nib
open class BaseViewController: UIViewController {

  static let message = "Cannot load this view controller from a nib"
  
  public init() {
    super.init(nibName: nil, bundle: nil)
  }

  @available(*, unavailable, message: "Cannot load this view controller from a nib")
  public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }

  @available(*, unavailable, message: "Cannot load this view controller from a nib")
  public required init?(coder: NSCoder) {
    fatalError("Cannot load this view controller from a nib")
  }
  
  /// Provides means to display associated view full screen
  /// - Parameter child: Child to display
  func addFullScreen(childViewController child: BaseViewController) {
    
    guard child.parent == nil else {
      return
    }
    
    addChild(child)
    view.addSubview(child.view)
    
    child.view.translatesAutoresizingMaskIntoConstraints = false
    
    let constraints = [
      view.leadingAnchor.constraint(equalTo: child.view.leadingAnchor),
      view.trailingAnchor.constraint(equalTo: child.view.trailingAnchor),
      view.topAnchor.constraint(equalTo: child.view.topAnchor),
      view.bottomAnchor.constraint(equalTo: child.view.bottomAnchor)
    ]
    
    constraints.forEach { $0.isActive = true}
    view.addConstraints(constraints)
    
    child.didMove(toParent: self)
  }
  
  /// Removes associated child screen
  /// - Parameter child: Child to remove
  func remove(childViewController child: BaseViewController?) {
    
    guard let child = child else { return }
    
    guard child.parent != nil else { return }
    
    child.willMove(toParent: nil)
    child.view.removeFromSuperview()
    child.removeFromParent()
    
  }
  
  /// Displays error message as an alert
  /// - Parameter errorMessage: Error information to display
  public func present(errorMessage: ErrorMessage) {
    let errorAlertController = UIAlertController(title: errorMessage.title,
                                                 message: errorMessage.message,
                                                 preferredStyle: .alert)
    let okAction = UIAlertAction(title: "OK", style: .default)
    errorAlertController.addAction(okAction)
    present(errorAlertController, animated: true, completion: nil)
  }

  
  /// Error message display
  /// - Parameters:
  ///   - errorMessage: Error information to display
  ///   - errorPresentation: errorPresentation description
  public func present(errorMessage: ErrorMessage,
                      withPresentationState errorPresentation: BehaviorSubject<ErrorPresentation?>) {
    
    errorPresentation.onNext(.presenting)
    let errorAlertController = UIAlertController(title: errorMessage.title,
                                                 message: errorMessage.message,
                                                 preferredStyle: .alert)
    let okAction = UIAlertAction(title: "OK", style: .default) { _ in
      errorPresentation.onNext(.dismissed)
      errorPresentation.onNext(nil)
    }
    errorAlertController.addAction(okAction)
    present(errorAlertController, animated: true, completion: nil)
    
  }
}
