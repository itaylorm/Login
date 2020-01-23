//
//  UITextFieldExtensions.swift
//  Login
//
//  Created by Taylor Maxwell on 11/29/19.
//  Copyright © 2019 Taylor Maxwell. All rights reserved.
//

import UIKit

/// Provides addtional features for UITextField
/// Based upon answers found here https://stackoverflow.com/questions/26800963/add-bottom-line-to-view-in-swift-objective-c-xamarin
extension UITextField {

  /// Configure passed text field appearance
  /// - Parameter field: Passed text field to format
  func format() {

    placeHolderColor = UIColor.gray
    addPadding()
    bottomBorderColor = Color.primary

  }

  /// Moves text to appear 10 pixels to the left
  func addPadding() {
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
    self.leftView = paddingView
    self.leftViewMode = .always
  }

  /// Provides access to placeholder text color to be changed
  @IBInspectable var placeHolderColor: UIColor? {
      get {
          return self.placeHolderColor
      }
      set {
        self.attributedPlaceholder =
            NSAttributedString(string: self.placeholder != nil ? self.placeholder!: "",
                               attributes: [NSAttributedString.Key.foregroundColor: newValue!])
      }
  }

  /// Provides access to the bottom border color
  @IBInspectable var bottomBorderColor: UIColor? {
      get {
          return self.bottomBorderColor
      }
      set {
        self.borderStyle = .none
        self.layer.masksToBounds = false
        self.layer.shadowColor = newValue?.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
      }
  }
}
