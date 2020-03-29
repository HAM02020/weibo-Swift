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
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "自动填充", target: self, action: #selector(autoFill))
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString = "https://api.weibo.com/oauth2/authorize?client_id=\(WBAppKey)&redirect_uri=\(WBRedirectURI)"
        //1> 确定要访问的对象
        guard let url = URL(string: urlString) else {
            return
        }
        //2> 建立请求
        let request = URLRequest(url:url)
        
        //3> 加载请求
        webView.loadRequest(request)
        
    }

    
    //MARK: - 监听方法
    
    @objc private func close(){
        dismiss(animated: true, completion: nil)
    }
    
    /// 自动填充用户名和密码
    @objc private func autoFill() {
        
        //准备js
        let js = "document.getElementById('userId').value = '13532265108';" + "document.getElementById('passwd').value = 'Kk2615391';"
        //让webview执行 js
        webView.stringByEvaluatingJavaScript(from: js)
    }
    
}
