//
//  ViewModelBase.swift
//  Login
//
//  Created by Taylor Maxwell on 11/27/19.
//  Copyright © 2019 Taylor Maxwell. All rights reserved.
//

import Foundation
import RxSwift

/// Base class for all view Models
/// Used to allow view models to be passed and have
/// common functions
class BaseViewModel {

  var errorMessages: Observable<ErrorMessage> {
    return errorMessagesSubject.asObservable()
  }

  let errorMessagesSubject = PublishSubject<ErrorMessage>()

}
