//
//  WBBaseViewController.swift
//  weibo
//
//  Created by 郝心如 on 2020/3/26.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit
//继承协议
class WBBaseViewController: UIViewController {
    
    var userLogon = false
    
    /// 表格视图  如果用户没有登陆就不显示
    var tableView : UITableView?
    
    ///刷新控件
    var refreshControl:UIRefreshControl?
    
    ///上拉刷新标记
    var isPullup = false
    
//    ///自定义导航条
//    var navigationBar:UINavigationBar = UINavigationBar()
//
//    lazy var navItem = UINavigationItem()

//    override var title: String? {
//        didSet {
//            navItem.title = title
//        }
//    }
    override func viewDidLoad() {
        
        userLogon ? setupTalbeView() : setupVisitorView()
    }
    
    
}



extension WBBaseViewController {
    
    
    
    @objc func setupUI() {
        view.backgroundColor = UIColor.white
        loadData()
    }
    ///设置d表格视图
    func setupTalbeView() {
        tableView = UITableView(frame: view.bounds, style: .plain)
        view.addSubview(tableView!)
        
        //设置数据源 和 代理 -> 目的 子类直接实现h数据源方法
        tableView?.dataSource = self
        tableView?.delegate = self
        
        //设置刷新控件
        //1> 实例化控件
        refreshControl = UIRefreshControl()
        
        //2> 添加到表格视图
        tableView?.addSubview(refreshControl!)
        
        //3> 添加监听方法
        refreshControl?.addTarget(self, action: #selector(loadData), for: .valueChanged)
        
        //设置内容缩进 我这里没必要 因为我没有自定义navigationbar
        //tableView?.contentInset = UIEdgeInsets(top: self.navigationController?.navigationBar.bounds.height ?? 0, left: 0, bottom: tabBarController?.tabBar.bounds.heigt ?? 49, right: 0)
    }
    
    ///设置访客视图
    private func setupVisitorView() {
        let visitorView = WBVisitorView(frame: view.bounds)
        
        view.addSubview(visitorView)
    }
    
    ///加载数据 - 由子类去实现
    @objc func loadData() {
        refreshControl?.endRefreshing()
    }
}
//MARK: -实现基类数据源方法 子类实现不用super
extension WBBaseViewController:UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    ///在显示最后一行的时候上拉刷新
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //1. 判断 indexPath是否是最后一行
        //indexPath.section(最大)/indexPath.row(最后一行)
        //1> row
        let row = indexPath.row
        //2. section
        let section = tableView.numberOfSections - 1
        //print("section --\(section)")
        
        if row<0 || section < 0 {
            return
        }
        //3. 行数
        let count = tableView.numberOfRows(inSection: section)
        
        if row == (count - 1) && !isPullup {
            print("上拉刷新")
            isPullup = true
            
            //开始刷新
            loadData()
        }
        
    }
    
}
