//
//  WBHomeViewController.swift
//  weibo
//
//  Created by 郝心如 on 2020/3/26.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit

private let cellId = "cellId"

class WBHomeViewController: WBBaseViewController {

    private lazy var statusList = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        //loadData()
    }
    ///加载数据
    override func loadData() {
        print("开始加载数据")
        // 模拟 延时 加载数据 -> dispatch_after
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+2, execute: {
            for i in 0..<20 {
                self.statusList.insert(i.description, at: 0)
            }
            //刷新表格
            print("刷新表格")
            self.refreshControl?.endRefreshing()
            self.tableView?.reloadData()
        })
        
        
        
    }
    ///显示好友
    @objc private func showFriends() {
        print(#function)
        let vc = WBDemoViewController()
        //隐藏底部导航栏
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }

}
///MARK: - 表格数据源方法
extension WBHomeViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statusList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 1.   取cell
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        // 2.   设置cell
        cell.textLabel?.text = statusList[indexPath.row]
        //3.    返回cell
        return cell
    }
}


///MARK: - 设置界面
extension WBHomeViewController {
    
    @objc override func setupUI() {
        super.setupUI()
        
        //设置导航栏按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "好友", target: self, action: #selector(showFriends))
        
        //注册原型cell
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }
    
}
