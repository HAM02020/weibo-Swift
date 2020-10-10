//
//  WBMainViewController.swift
//  weibo-11.0
//
//  Created by 郝心如 on 2020/3/26.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit
import SVProgressHUD
class WBMainViewController: UITabBarController {

    //定时器
    private var timer :Timer?
    
    private var old_count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupChildControllers()
        setupComposeButton()
        setupTimer()
        
        setupNewFeatureViews()
        
        //设置代理 页面之间转换
        delegate = self
        
        // 注册通知
        NotificationCenter.default.addObserver(self, selector: #selector(userLogin), name: NSNotification.Name(rawValue: WBUserShouldLoginNotification), object: nil)
        

        
        
    }
    
    deinit {
        //销毁时钟
        timer?.invalidate()
        
        //注销通知
        NotificationCenter.default.removeObserver(self)
    }
    
    
    //MARK: - 支持横屏
    //  protrait    竖屏
    //  landscape   竖屏
    //override var supportedInterfaceOrientations: UIInterfaceOrientationMask = tabBarControllerSupportedInterfaceOrientations()
    
    // MARK: - 私有控件
    lazy private var composeButton:UIButton = UIButton()
    
    
    //MARK: - 监听方法
    /// 撰写微博
    // FIXME: 没有实现
    @objc private func composeStatus() {
        print("撰写微博")
        
        //FIXME: 0> 判断是否登陆
        
        //1> 实例化视图
        let v = WBComposeTypeView.composeTypeView()
        
        //2>  显示视图
        v.show { [weak v] (clsName) in
            //展现撰写微博控制器
            guard let clsName = clsName,
                let cls = NSClassFromString("\(Bundle.main.infoDictionary?["CFBundleName"] as? String ?? "").\(clsName)") as? UIViewController.Type
                else {
                    v?.removeFromSuperview()
                    return
            }
            let vc = cls.init()
            let nav = UINavigationController(rootViewController: vc)
            //让导航控制器强行更新约束
            nav.view.layoutIfNeeded()
            self.present(nav, animated: true) {
                v?.removeFromSuperview()
            }
        }
    }
    
    @objc private func userLogin(n:Notification) {
        print("用户登陆通知\(n)")
        
        var when = DispatchTime.now()
        
        //如果有值 判断 提示用户重新登陆
        if n.object != nil {
            //渐变样式
            SVProgressHUD.setDefaultMaskType(.gradient)

            SVProgressHUD.showInfo(withStatus: "用户登陆已经超时，需要重新登陆")
            
            when = DispatchTime.now() + 2

        }
        DispatchQueue.main.asyncAfter(deadline: when) {
            SVProgressHUD.setDefaultMaskType(.clear)
            //展现登陆控制器
            
        }
        let nav = UINavigationController(rootViewController: WBOAuthViewController())
        
        self.present(nav, animated: true, completion: nil)
        
        
    }
    
}
//MARK: - 新特性视图
extension WBMainViewController  {
    func setupNewFeatureViews(){
        
        //0. 判断是否登陆
        if !WBNetworkManager.shared().userLogon {
            return
        }
        
        //1. 检查版本是否更新
        let v = isNewVersion ? WBNewFeatureView.newFeatureView() : WBWelcomeView.welcomeView()
        //2. 如果更新，显示新特性
       
        //3. 添加视图
        v.frame = view.bounds
        
        view.addSubview(v)
    }
    
    private var isNewVersion:Bool {
        //1。 取当前的版本号
        print(Bundle.main.infoDictionary ?? "")
        //2. 取保存在 ‘Document(iTunes备份)[最理想保存在用户偏好]’目录中的之前版本号
        let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let filePath = (docDir as NSString).appendingPathComponent("Version")
        let sandboxVersion = (try? String(contentsOfFile: filePath)) ?? ""
       
        print("sandBox\(sandboxVersion)")
        //3. 将当前版本号保存在沙盒
        let currentVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
        print(currentVersion)
        
        _ = try? currentVersion.write(toFile: filePath, atomically: true, encoding: .utf8)
        //4. 返回两个版本号是否一致
        return currentVersion != sandboxVersion
    }
}

extension WBMainViewController: UITabBarControllerDelegate {
    
    /// 将要选择 TabBarItem
    /// - Parameters:
    ///   - tabBarController: tabbarcontroller
    ///   - viewController: 目标控制器
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        print("将要切换到\(viewController)")
        
        //1> 获取控制器在数组中的索引
        let index = (viewControllers! as NSArray).index(of:viewController)
        
        //2> 获取当前索引,同时 index也是首页 进行下拉刷新
        if selectedIndex == 0 && index == selectedIndex {
            print("点击首页")
            //3> 让表格滚动到顶部
            let nav = viewControllers?[0] as! UINavigationController
            let vc = nav.viewControllers[0] as! WBHomeViewController
            //滚动到顶部
            vc.refreshControl?.refreshView.refreshState = .Pulling
            vc.tableView?.setContentOffset(CGPoint(x: 0, y: -MGRefreshOffset-88), animated: true)
            
            //4> 刷新数据
            //vc.refreshControl?.beginRefreshing()
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1) {
                vc.loadData()
                //vc.refreshControl?.endRefreshing()
                //回复表格高度
                //vc.tableView?.setContentOffset(CGPoint(x: 0, y: MGRefreshOffset+88), animated: true)
                self.tabBar.items?[0].badgeValue = nil
                UIApplication.shared.applicationIconBadgeNumber = 0
            }
        }
        
        //容错 按钮旁边的空白区域 点了不跳转
        return !viewController.isMember(of: UIViewController.self)
    }
    
}


//MARK: - 时钟相关方法
extension WBMainViewController {
    
    ///定义时钟
    private func setupTimer() {
        
        timer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(updataTimer), userInfo: nil, repeats: true)
        
        
    }
    
    /// 时钟触发方法
    @objc private func updataTimer() {
        
        if !WBNetworkManager.shared().userLogon{
            return
        }
        
        WBNetworkManager.shared().getUnreadCount{(count) in
            if count > self.old_count {
                print("有\(count)条新微博")
                
                // 设置 tabbaritem 的 badgeNumber
                self.tabBar.items?[0].badgeValue = count > 0 ? "\(count)" : nil
                
                //设置 App 的 badgeNumber
                UIApplication.shared.applicationIconBadgeNumber = count
                self.old_count = count
            }
            
        }
    }
    
}

extension WBMainViewController {
    
    private func setupComposeButton(){
        
        guard let image1: UIImage = UIImage(named: "button_add_selected"),
        let image2 :UIImage = UIImage(named: "button_add") else{
            
            return
        }
        composeButton.setImage(image1, for: .normal)
        composeButton.setImage(image2, for: .highlighted)

        //let count = CGFloat(integerLiteral: viewControllers?.count ?? 0)
        //设置每个tabbbar宽度 -1 可以防止穿帮（w手指误触）
        //let w = tabBar.bounds.width/count-1
        composeButton.frame = CGRect(x: UIScreen.main.bounds.width/2 - 32, y: 4, width: 64, height: 64)
        //composeButton.frame = tabBar.bounds.insetBy(dx: 2*w, dy: -10)
        
        tabBar.addSubview(composeButton)
        
        // 按钮监听方法
        composeButton.addTarget(self, action: #selector(composeStatus), for: .touchUpInside)
    }
    
    
    private func setupChildControllers() {
        
        //0 获取沙盒json 路径
        let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let jsonPath = (docDir as NSString).appendingPathComponent("main.json")
        
        //加载data
        var data = NSData(contentsOfFile: jsonPath)
        
        //判断 data 是否有内容 如果没有 说明本地沙盒没有文件
        if data == nil {
            //从Bundle加载data
            let path = Bundle.main.path(forResource: "main.json", ofType: nil)
            data = NSData(contentsOfFile: path!)
        }
        
        
        //从bundle 加载配置 json
        guard let array = try? JSONSerialization.jsonObject(with: data! as Data, options: []) as? [[String:Any]] else {
            return
        }
        
        
//        let array : [[String:Any]] = [
//            ["clsName":"WBHomeViewController","title":"首页","imageName":"home",
//            "visitorInfo":["imageName":"","message":"关注一些人，回这里看看有什么惊喜"]
//            ],
//            ["clsName":"WBMessageViewController","title":"消息","imageName":"message_center",
//            "visitorInfo":["imageName":"visitordiscover_image_message","message":"登陆后，别人评论你的微博，发给你的消息，都会在这里收到通知"]
//            ],
//            ["clsName":"UIViewController"],
//            ["clsName":"WBDiscoverViewController","title":"发现","imageName":"discover",
//            "visitorInfo":["imageName":"visitordiscover_image_discover","message":"登陆后，最新，最热微博，尽在掌握，不再会与实事潮流擦肩而过"]
//            ],
//            ["clsName":"WBProfileViewController","title":"我","imageName":"profile",
//            "visitorInfo":["imageName":"visitordiscover_image_profile","message":"登陆后，你的微博、相册、个人资料会显示在这里，展示给别人"]
//            ],
//        ]
//
//        //(array as NSArray).write(toFile: "/Users/haoxinru/Desktop/demo.plist", atomically: true)
//
//        let data = try! JSONSerialization.data(withJSONObject: array, options: [.prettyPrinted])
//        (data as NSData).write(toFile: "/Users/haoxinru/Desktop/demo.json", atomically: true)
//
        var arrayM = [UIViewController]()
        for dict in array {
            arrayM.append(controller(dict:dict))
        }
        viewControllers = arrayM
        
    }
    ///使用字典创建一个子控制器
    ///
    /// - parameter dict 信息字典[clsName,title,image]
    private func controller(dict: [String:Any])->UIViewController {
        guard
            let clsName = dict["clsName"] as? String,
            let title = dict["title"] as? String,
            let imageName = dict["imageName"] as? String,
            //利用反射生生成类
            let cls = NSClassFromString("\(Bundle.main.infoDictionary?["CFBundleName"] as? String ?? "").\(clsName)") as? WBBaseViewController.Type,
            let visitorDict = dict["visitorInfo"] as? [String:String] else {
                return UIViewController()
        }
        //2. 创建视图控制器
        let vc = cls.init()
        vc.title = title
        
        //设置控制器的访客信息字典
        vc.visitorInfoDictionary = visitorDict
        
        //设置tabbar的标题颜色 和字体
        vc.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.orange], for: .highlighted)
        //字体 默认为12 号
        vc.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.darkGray,NSAttributedString.Key.font:UIFont.systemFont(ofSize: 14)], for: .normal)
        //3. 设置图像
        vc.tabBarItem.image = UIImage(named: "tabbar_\(imageName)")
        vc.tabBarItem.selectedImage = UIImage(named: "tabbar_\(imageName)_selected")?.withRenderingMode(.alwaysOriginal)
        let nav = WBNavigationController(rootViewController: vc)
        return nav
    }
}
