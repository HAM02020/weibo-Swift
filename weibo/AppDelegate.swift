//
//  AppDelegate.swift
//  weibo
//
//  Created by 郝心如 on 2020/3/25.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window:UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow()
        window?.backgroundColor=UIColor.white
        window?.rootViewController=WBMainViewController()
        window?.makeKeyAndVisible()
        
        
        return true
    }

    

}

