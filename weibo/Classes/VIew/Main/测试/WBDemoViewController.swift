//
//  WBDemoViewController.swift
//  weibo-11.0
//
//  Created by 郝心如 on 2020/3/26.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit

class WBDemoViewController: WBBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        //设置标题
        title = "第\(navigationController?.viewControllers.count ?? 0)个"
    }
    
    //MARK: - 监听方法
    ///继续PUSH一个新控制器
    @objc private func showNext() {
        let vc = WBDemoViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension WBDemoViewController {
        
        override func setupUI() {
            super.setupUI()
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "下一个", target: self, action: #selector(showNext))
            
        }
}
