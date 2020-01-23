//
//  AppDelegate.swift
//  Login
//
//  Created by Taylor Maxwell on 11/23/19.
//  Copyright © 2019 Taylor Maxwell. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  private let dependencyContainer = AppDependencyContainer()
  var theme: Theme = LightTheme()

  var window: UIWindow?

  /// Application startup
  /// - Parameters:
  ///   - application: Reference to the application settings
  ///   - launchOptions: Options set (if any)
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    let mainVC = dependencyContainer.makeMainViewController()

    window = UIWindow(frame: UIScreen.main.bounds)
    window?.makeKeyAndVisible()

    window?.rootViewController = mainVC

    applyTheme(application)

    return true
  }

  /// Applies theme based upon the interface style
  /// - Parameter application: Application reference
  private func applyTheme(_ application: UIApplication) {

    if #available(iOS 13.0, *) {

      if UITraitCollection.current.userInterfaceStyle == .dark {
        theme = DarkTheme()
      } else {
        theme = LightTheme()
      }

    } else {
      theme = LightTheme()
    }

    window?.backgroundColor = theme.backgroundColor
    window?.tintColor = theme.iconTint

    theme.apply(for: application)

  }

}
