//
//  UIDeviceExtensions.swift
//  CommonFramework
//
//  Created by Admin on 8/10/21.
//

import UIKit

public extension UIDevice {
    // Returns true if the device is iPhone
    static var isPhone: Bool {
        return UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone
    }
    
    // Returns true if the device is iPad
    static var isPad: Bool {
        return UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad
    }
    
    static var hasTopNotch: Bool {
        // with notch: 44.0 on iPhone X, XS, XS Max, XR.
        // without notch: 24.0 on iPad Pro 12.9" 3rd generation, 20.0 on iPhone 8 on iOS 12+.
        return UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.safeAreaInsets.top ?? 0 > 24

    }
    
    static var hasBottomSafeAreaInsets: Bool {
        // with home indicator: 34.0 on iPhone X, XS, XS Max, XR.
        // with home indicator: 20.0 on iPad Pro 12.9" 3rd generation.
        return UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.safeAreaInsets.bottom ?? 0 > 0
    }
    
    /// Gets the Device identifier String.
    static var identifier: String {
      var systemInfo = utsname()
      uname(&systemInfo)
      
      let machineMirror = Mirror(reflecting: systemInfo.machine)
      let identifier = machineMirror.children.reduce("") { (identifier, element) in
        guard let value = element.value as? Int8, value != 0 else {
          return identifier
        }
        return identifier + String(UnicodeScalar(UInt8(value)))
      }
      return identifier
    }
    
}
