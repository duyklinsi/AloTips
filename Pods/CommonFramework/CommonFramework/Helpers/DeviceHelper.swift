//
//  DeviceHelper.swift
//  CommonFramework
//
//  Created by Admin on 8/10/21.
//

import UIKit

@objc(DeviceModel)
public enum DeviceModel: Int {
    case iPodTouch5
    case iPodTouch6
    case iPhone4
    case iPhone4s
    case iPhone5
    case iPhone5c
    case iPhone5s
    case iPhone6
    case iPhone6Plus
    case iPhone6s
    case iPhone6sPlus
    case iPhone7
    case iPhone7Plus
    case iPhone8
    case iPhone8Plus
    case iPhoneX
    case iPhoneXS
    case iPhoneXSMax
    case iPhoneXR
    case iPhoneSE
    case iPad2
    case iPad3
    case iPad4
    case iPadAir
    case iPadAir2
    case iPadMini
    case iPadMini2
    case iPadMini3
    case iPadMini4
    case iPadPro
    case iPadProLarge
    case iPad5
    case iPadPro2
    case iPadProLarge2
    case iPad6
    case iPadPro3       //iPad Pro (11-inch)
    case iPadProLarge3  //iPad Pro (12.9-inch) (3rd generation)
    case appleTv
    case appleTv4k
    case homePod
    case simulator
    case unknown
}

public struct DeviceHelper {
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
    
    /// Gets the model name for the device.
    static var model: DeviceModel {
        switch identifier {
        case "iPod5,1":                                     return .iPodTouch5
        case "iPod7,1":                                     return .iPodTouch6
        case "iPhone4,1":                                   return .iPhone4s
        case "iPhone5,1", "iPhone5,2":                      return .iPhone5
        case "iPhone5,3", "iPhone5,4":                      return .iPhone5c
        case "iPhone6,1", "iPhone6,2":                      return .iPhone5s
        case "iPhone7,2":                                   return .iPhone6
        case "iPhone7,1":                                   return .iPhone6Plus
        case "iPhone8,1":                                   return .iPhone6s
        case "iPhone8,2":                                   return .iPhone6sPlus
        case "iPhone8,3", "iPhone8,4":                      return .iPhoneSE
        case "iPhone9,1", "iPhone9,3":                      return .iPhone7
        case "iPhone9,2", "iPhone9,4":                      return .iPhone7Plus
        case "iPhone10,1", "iPhone10,4":                    return .iPhone8
        case "iPhone10,2", "iPhone10,5":                    return .iPhone8Plus
        case "iPhone10,3","iPhone10,6":                     return .iPhoneX
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":    return .iPad2
        case "iPad3,1", "iPad3,2", "iPad3,3":               return .iPad3
        case "iPad3,4", "iPad3,5", "iPad3,6":               return .iPad4
        case "iPad4,1", "iPad4,2", "iPad4,3":               return .iPadAir
        case "iPad5,3", "iPad5,4":                          return .iPadAir2
        case "iPad2,5", "iPad2,6", "iPad2,7":               return .iPadMini
        case "iPad4,4", "iPad4,5", "iPad4,6":               return .iPadMini2
        case "iPad4,7", "iPad4,8", "iPad4,9":               return .iPadMini3
        case "iPad5,1", "iPad5,2":                          return .iPadMini4
        case "iPad6,3", "iPad6,4":                          return .iPadPro
        case "iPad6,7", "iPad6,8":                          return .iPadProLarge
        case "iPad6,11", "iPad6,12":                        return .iPad5
        case "iPad7,3", "iPad7,4":                          return .iPadPro2
        case "iPad7,1", "iPad7,2":                          return .iPadProLarge2
        case "iPad7,5", "iPad7,6":                          return .iPad6
        case "i386", "x86_64":                              return .simulator
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":         return .iPhone4
        case "iPhone11,2":                                  return .iPhoneXS
        case "iPhone11,4", "iPhone11,6":                    return .iPhoneXSMax
        case "iPhone11,8":                                  return .iPhoneXR
        case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4":    return .iPadPro3
        case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8":    return .iPadProLarge3
        case "AppleTV5,3":                                  return .appleTv
        case "AppleTV6,2":                                  return .appleTv4k
        case "AudioAccessory1,1":                           return .homePod
        default:                                            return .unknown
        }
    }
    
    /// Retrieves the current device type.
    static var userInterfaceIdiom: UIUserInterfaceIdiom {
        return UIDevice.current.userInterfaceIdiom
    }
    
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
}

