//
//  WBBaseViewController.swift
//  weibo
//
//  Created by 郝心如 on 2020/3/26.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit

class WBBaseViewController: UIViewController {
    
    ///自定义导航条
    var navigationBar:UINavigationBar = UINavigationBar()
    
    lazy var navItem = UINavigationItem()
    
   
    override var title: String? {
        didSet {
            navItem.title = title
        }
    }
}


extension WBBaseViewController {
    
    @objc func setupUI() {
        view.backgroundColor = UIColor.red
        navigationBar.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44)
        
        
        //navigationBar.backgroundColor = UIColor.white
        //view.addSubview(navigationBar)
        navigationBar.items = [navItem]
        navigationBar.barTintColor = UIColor.white
        
    }
}
