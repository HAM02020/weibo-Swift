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
        
        loadAppInfo()
        
        return true
    }

}

//MARK - 从服务器加载应用程序信息
extension AppDelegate   {
    
    private func loadAppInfo() {
        
        //1. 模拟异步
        DispatchQueue.global().async {
            
            //1> url
            let url = Bundle.main.url(forResource: "main.json", withExtension: nil)
            
            //2> data
            let data = NSData(contentsOf: url!)
            
            //3> 写入磁盘
            let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
            let jsonPath = (docDir as NSString).appendingPathComponent("main.json")
            data?.write(toFile: jsonPath, atomically: true)
            
            print("应用程序加载完毕\(jsonPath)")
            
        }
    }
}
