//
//  AppInfos.swift
//  CommonFramework
//
//  Created by Admin on 8/10/21.
//

import UIKit

public struct AppHelper {
    ///  app's name
    public static var appDisplayName: String? {
        if let bundleDisplayName = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String {
            return bundleDisplayName
        } else if let bundleName = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String {
            return bundleName
        }
        return nil
    }
    
    public static var identifier: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleIdentifier") as? String
    }
    
    public static var targetedVersion: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleInfoDictionaryVersion") as? String
    }
    
    public static var appVersion: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
    
    public static var appBuild: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String
    }
    
    public static var osVersion: String? {
        let version = ProcessInfo.processInfo.operatingSystemVersion
        return "\(version.majorVersion).\(version.minorVersion).\(version.patchVersion)"
    }
    
    public static var osName: String? {
            #if os(iOS)
                return "iOS"
            #elseif os(watchOS)
                return "watchOS"
            #elseif os(tvOS)
                return "tvOS"
            #elseif os(macOS)
                return "OS X"
            #elseif os(Linux)
                return "Linux"
            #else
                return "Unknown"
            #endif
    }
    
    // Return device version ""
    public static var deviceVersion: String {
        var size: Int = 0
        sysctlbyname("hw.machine", nil, &size, nil, 0)
        var machine = [CChar](repeating: 0, count: Int(size))
        sysctlbyname("hw.machine", &machine, &size, nil, 0)
        return String(cString: machine)
    }

    public static var isDebug: Bool {
        #if DEBUG
            return true
        #else
            return false
        #endif
    }

    public static var isRelease: Bool {
       return !isDebug
    }
    
    public static var isSimulator: Bool {
//      #if (arch(i386) || arch(x86_64)) && os(iOS)
        #if targetEnvironment(simulator)
            return true
        #else
            return false
        #endif
    }
    
    public static var isDevice: Bool {
        return !isSimulator
    }
    
    public static func appURLStringWithAppID(_ appID: String) -> String{
        return "itms-apps://itunes.apple.com/cn/app/id\(appID)"
    }
    
    public static func appInfoURLStringWithAppID(_ appID: String) -> String{
        return "http://itunes.apple.com/lookup?id=\(appID)"
    }


}
