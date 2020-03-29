//
//  AppDelegate.swift
//  weibo
//
//  Created by 郝心如 on 2020/3/25.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit
import SVProgressHUD
import AFNetworking
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window:UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions:
        [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setupAdditions()

        
        // Override point for customization after application launch.
        window = UIWindow()
        window?.backgroundColor=UIColor.white
        window?.rootViewController=WBMainViewController()
        window?.makeKeyAndVisible()
        
        loadAppInfo()
        
        return true
    }

}

//MARK: - 设置应用程序额外信息
extension AppDelegate   {
    private func setupAdditions(){
        
        // 1. 设置SVDProguressHUD 最小解除时间
        SVProgressHUD.setMinimumDismissTimeInterval(1)
        
        //2 .设置网络加载 指示器
        AFNetworkActivityIndicatorManager.shared().isEnabled = true
        
        //3 .设置通知权限获取
        
        //取得用户授权显示通知[]
        //过期了 ios11不支持
//        let notifySettiings = UIUserNotificationSettings(types: [.alert,.badge,.sound], categories: nil)
//        application.registerUserNotificationSettings(notifySettiings)
        //新写法
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge,.carPlay]) {
         (success, error) in
         //Parse errors and track state
            
                }
        
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
