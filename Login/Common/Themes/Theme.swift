//
//  Theme.swift
//  Login
//
//  Created by Taylor Maxwell on 11/27/19.
//  Copyright © 2019 Taylor Maxwell. All rights reserved.
//

import UIKit

/// Provides a means to generate colors and styles to
/// the entire application
/// Based upon this article: https://basememara.com/protocol-oriented-themes-for-ios-apps/
protocol Theme {

  var primary: UIColor { get}

  var tint: UIColor { get }
  var secondaryTint: UIColor { get }
  var iconTint: UIColor { get }

  var backgroundColor: UIColor { get }
  var separatorColor: UIColor { get }
  var selectionColor: UIColor { get }

  var labelColor: UIColor { get }
  var secondaryLabelColor: UIColor { get }
  var subtleLabelColor: UIColor { get }
  var titleLabelColor: UIColor { get }

  var barStyle: UIBarStyle { get }

  var borderColor: CGColor { get }

}

extension Theme {

  func apply(for application: UIApplication) {

    application.windows.reload()

    UITabBar.appearance().barStyle = barStyle

    UINavigationBar.appearance().barStyle = barStyle
    UINavigationBar.appearance().tintColor = labelColor
    UINavigationBar.appearance().backgroundColor = Color.primary
    UINavigationBar.appearance().titleTextAttributes = [
       .foregroundColor: labelColor
    ]

    if #available(iOS 11.0, *) {
       UINavigationBar.appearance().largeTitleTextAttributes = [
           .foregroundColor: labelColor
       ]
    }

    UICollectionView.appearance().backgroundColor = backgroundColor
    UITableView.appearance().backgroundColor = backgroundColor
    UITableView.appearance().separatorColor = separatorColor
    UITableViewCell.appearance().backgroundColor = .clear

    UIView.appearance(whenContainedInInstancesOf: [UITableViewHeaderFooterView.self])
       .backgroundColor = selectionColor

    UILabel.appearance(whenContainedInInstancesOf: [UITableViewHeaderFooterView.self])
       .textColor = secondaryLabelColor

    UILabel.appearance().textColor = labelColor

    UIButton.appearance().setTitleColor(titleLabelColor, for: .normal)

    UISwitch.appearance().tintColor = tint

    UITextField.appearance().backgroundColor = backgroundColor

   }
}

extension UIWindow {

    /// Unload all views and add back.
    /// Useful for applying `UIAppearance` changes to existing views.
    func reload() {
        subviews.forEach { view in
            view.removeFromSuperview()
            addSubview(view)
        }
    }
}

extension Array where Element == UIWindow {

    /// Unload all views for each `UIWindow` and add back.
    /// Useful for applying `UIAppearance` changes to existing views.
    func reload() {
        forEach { $0.reload() }
    }
}
