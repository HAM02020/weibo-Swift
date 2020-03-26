//
//  WBMainViewController.swift
//  weibo-11.0
//
//  Created by 郝心如 on 2020/3/26.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit

class WBMainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupChildControllers()
        setupComposeButton()
    }
    
    // MARK: - 私有控件
    lazy private var composeButton:UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    
    
    //MARK: - 监听方法
    /// 撰写微博
    // FIXME: 没有实现
    @objc private func composeStatus() {
        print("撰写微博")
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
        let count = CGFloat(integerLiteral: viewControllers?.count ?? 0)
        //设置每个tabbbar宽度 -1 可以防止穿帮（w手指误触）
        let w = tabBar.bounds.width/count-1
        
        composeButton.frame = tabBar.bounds.insetBy(dx: 2*w, dy: 0)
        
        tabBar.addSubview(composeButton)
        
        // 按钮监听方法
        composeButton.addTarget(self, action: #selector(composeStatus), for: .touchUpInside)
    }
    
    private func setupChildControllers() {
        let array = [
            ["clsName":"WBHomeViewController","title":"首页","imageName":"home"],
            ["clsName":"WBMessageViewController","title":"消息","imageName":"message_center"],
            ["clsName":"UIViewController"],
            ["clsName":"WBDiscoverViewController","title":"发现","imageName":"discover"],
            ["clsName":"WBProfileViewController","title":"我","imageName":"profile"],
        ]
        var arrayM = [UIViewController]()
        for dict in array {
            arrayM.append(controller(dict:dict))
        }
        viewControllers = arrayM
        
    }
    ///使用字典创建一个子控制器
    ///
    /// - parameter dict 信息字典[clsName,title,image]
    private func controller(dict: [String:String])->UIViewController {
        guard let clsName = dict["clsName"],
        let title = dict["title"],
        let imageName = dict["imageName"],
        //利用反射生生成类
        let cls = NSClassFromString("\(Bundle.main.infoDictionary?["CFBundleName"] as? String ?? "").\(clsName)") as? UIViewController.Type else {
            return UIViewController()
        }
        //2. 创建视图控制器
        let vc = cls.init()
        vc.title = title
        //设置tabbar的标题颜色 和字体
        vc.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.orange], for: .highlighted)
        //字体 默认为12 号
        vc.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12)], for: .normal)
        //3. 设置图像
        vc.tabBarItem.image = UIImage(named: "tabbar_" + imageName)
        vc.tabBarItem.selectedImage = UIImage(named: "tabbar_" + imageName + "_selected")?.withRenderingMode(.alwaysOriginal)
        let nav = WBNavigationController(rootViewController: vc)
        return nav
    }
}
