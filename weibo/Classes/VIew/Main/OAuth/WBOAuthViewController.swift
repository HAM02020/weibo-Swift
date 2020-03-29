//
//  WBOAuthViewController.swift
//  weibo
//
//  Created by 郝心如 on 2020/3/29.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit


///通过webView加载新浪微博授权页面控制器
class WBOAuthViewController: UIViewController {

    private lazy var webView = UIWebView()
    
    override func loadView() {
        view = webView
        
        view.backgroundColor = UIColor.white
        
        // 设置导航栏
        title = "登陆新浪微博"
        //导航栏按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", target: self, action: #selector(close), isBack: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    //MARK: - 监听方法
    
    @objc private func close(){
        dismiss(animated: true, completion: nil)
    }

}
