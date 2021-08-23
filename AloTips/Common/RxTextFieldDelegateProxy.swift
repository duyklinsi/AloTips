//
//  RxTextFieldDelegateProxy.swift
//  AloTips
//
//  Created by Admin on 8/23/21.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class RxTextFieldDelegateProxy: DelegateProxy<UITextField, UITextFieldDelegate>, DelegateProxyType, UITextFieldDelegate {
  init(textField: UITextField) {
     super.init(parentObject: textField, delegateProxy: RxTextFieldDelegateProxy.self)
  }

  static func registerKnownImplementations() {
     self.register { RxTextFieldDelegateProxy(textField: $0)}
  }

  static func currentDelegate(for object: UITextField) -> UITextFieldDelegate? {
     return object.delegate
  }

  static func setCurrentDelegate(_ delegate: UITextFieldDelegate?, to object: UITextField) {
        object.delegate = delegate
  }
}

extension Reactive where Base: UITextField {
   public var delegate: DelegateProxy<UITextField, UITextFieldDelegate> {
      return RxTextFieldDelegateProxy.proxy(for: base)
   }
 
   public var editingDidEnd: Observable<String> {
      return delegate.sentMessage(#selector(UITextFieldDelegate.textFieldDidEndEditing(_:))).map { value in
         guard let textField = value[0] as? UITextField else { return "" }
         return textField.text!
      }
   }
 
}
