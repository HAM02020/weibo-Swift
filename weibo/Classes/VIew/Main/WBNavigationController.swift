//
//  WBNavigationController.swift
//  weibo-11.0
//
//  Created by 郝心如 on 2020/3/26.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit

class WBNavigationController: UINavigationController {

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {

        //判断不是根控制器才隐藏
        if viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        
        super.pushViewController(viewController, animated: true)
    }

}
