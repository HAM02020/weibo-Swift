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
    
    
    /// 表格视图  如果用户没有登陆就不显示
    var tableView : UITableView?
    
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
        setupTalbeView()
    }
}



extension WBBaseViewController {
    
    @objc func setupUI() {
        view.backgroundColor = UIColor.white
        loadData()
    }
    //设置d表格视图
    func setupTalbeView() {
        tableView = UITableView(frame: view.bounds, style: .plain)
        view.addSubview(tableView!)
        
        //设置数据源 和 代理 -> 目的 子类直接实现h数据源方法
        //tableView?.dataSource = self
        //tableView?.delegate = self
    }
    ///加载数据 - 由子类去实现
    func loadData() {
        
    }
}
//MARK: -实现基类数据源方法 子类实现不用super
extension WBBaseViewController:UITableViewDataSource,UITableViewDragDelegate {
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        return []
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
    
    
}
