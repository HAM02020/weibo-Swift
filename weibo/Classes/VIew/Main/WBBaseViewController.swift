//
//  WBBaseViewController.swift
//  weibo
//
//  Created by 郝心如 on 2020/3/26.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit

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

    }
    //设置d表格视图
    func setupTalbeView() {
        tableView = UITableView(frame: view.bounds, style: .plain)
        view.addSubview(tableView!)
    }
}
