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

    private lazy var listViewModel = WBStatusListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        //loadData()
        print("Home LoadData")
    }
    ///加载数据
    override func loadData() {
        
        listViewModel.loadStatus(isPullup:self.isPullup) { (isSuccess,shouldRefresh) in
            //刷新表格
            print("加载数据结束")
            //k结束刷新控件
            self.refreshControl?.endRefreshing()
            //恢复刷新标记
            self.isPullup = false
            if shouldRefresh {
                self.tableView?.reloadData()
            }

        }
        

        
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
        return listViewModel.statusList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 1.   取cell
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        // 2.   设置cell
        cell.textLabel?.text = listViewModel.statusList[indexPath.row].text
        //3.    返回cell
        return cell
    }
}


///MARK: - 设置界面
extension WBHomeViewController {
    
    override func setupTalbeView() {
        super.setupTalbeView()
        //设置导航栏按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "好友", target: self, action: #selector(showFriends))
        
        //注册原型cell
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }

    
}
