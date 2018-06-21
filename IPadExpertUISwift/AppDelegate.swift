//
//  AppDelegate.swift
//  IPadExpertUISwift
//
//  Created by piyush sinroja on 21/06/18.
//  Copyright © 2018 Piyush. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        IPadPixelHelper.defaultIPadScreenWidth = DefaultIPadWidthPixels.IPadPro9Inch.rawValue
        IPadPixelHelper.defaultIPadScreenHeight = DefaultIPadHeightPixels.IPadPro9Inch.rawValue
        return true
    }
}
