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
        //super.viewDidLoad()
        //设置标题
        title = "第\(navigationController?.viewControllers.count ?? 0)个"
        view.backgroundColor = UIColor.white
        setupTalbeView()
    }
    
    //MARK: - 监听方法
    ///继续PUSH一个新控制器
    @objc private func showNext() {
        let vc = WBDemoViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension WBDemoViewController {
        
        ///重写父类方法
    override func setupTalbeView() {
        super.setupTalbeView()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "下一个", target: self, action: #selector(showNext))
    }
}
