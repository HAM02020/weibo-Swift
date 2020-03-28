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
        loadData()
    }
    ///加载数据
    override func loadData() {
        
        //用网络工具加载微博数据
        let urlString = "https://api.weibo.com/2/statuses/home_timeline.json"
        let params = ["access_token":"2.00S7fvUGU1U7fEba8e1add890UizGg"]
        
//        WBNetworkManager.shared.get(urlString, parameters: params, progress: nil, success: { (_, json) in
//            print(json ?? "网络请求成功")
//        }) { (_, error) in
//            print("网络请求失败\(error)")
//        }
        
        WBNetworkManager.shared.request(URLString: urlString, parameters: params) { (json, isSuccess) in
            print(json)
        }
        
        print("开始加载数据\(WBNetworkManager.shared)")
        // 模拟 延时 加载数据 -> dispatch_after
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+2, execute: {
            for i in 0..<20 {
                if self.isPullup {
                    //将数据追加到d底部
                    self.statusList.append("上拉\(i)")
                }
                self.statusList.insert(i.description, at: 0)
            }
            //刷新表格
            print("加载数据结束")
            //k结束刷新控件
            self.refreshControl?.endRefreshing()
            //恢复刷新标记
            self.isPullup = false
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
    
    override func setupTalbeView() {
        super.setupTalbeView()
        //设置导航栏按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "好友", target: self, action: #selector(showFriends))
        
        //注册原型cell
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }

    
}
