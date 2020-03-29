//
//  WBOAuthViewController.swift
//  weibo
//
//  Created by 郝心如 on 2020/3/29.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit
import SVProgressHUD

///通过webView加载新浪微博授权页面控制器
class WBOAuthViewController: UIViewController {

    private lazy var webView = UIWebView()
    
    override func loadView() {
        view = webView
        
        view.backgroundColor = UIColor.white
        //取消页面滚动
        webView.scrollView.isScrollEnabled = false
        //设置代理
        webView.delegate = self
        
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
        
        SVProgressHUD.dismiss()
        
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


extension WBOAuthViewController : UIWebViewDelegate {
    /// webView将要加载请求
    /// - Parameters:
    ///   - webView: webView
    ///   - request: j要加载的请求
    ///   - navigationType: 导航类型
    ///
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebView.NavigationType) -> Bool {
        
        if request.url?.absoluteString.hasPrefix(WBRedirectURI) == false {
            return true
        }
        
        print("加载请求 ---- \(String(describing: request.url?.absoluteString))")
        print("加载请求 ---- \(String(describing: request.url?.query))")
        
        if request.url?.query?.hasPrefix("code=") == false {
            print("取消授权")
            close()
            return false
        }
        
        let code = String(request.url?.query?["code=".endIndex...] ?? "")
        print("获取授权码\(code)")
        
        //4> 使用授权吗 获取AccessToken
        WBNetworkManager.shared().getAccessToken(code: code)
        close()
        return false
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        SVProgressHUD.show()
    }
    func webViewDidFinishLoad(_ webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
}
