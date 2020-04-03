//
//  WBHomeViewController.swift
//  weibo
//
//  Created by 郝心如 on 2020/3/26.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit
///原创微博可重用cell
private let originnalCellId = "originnalCellId"
///被转发微博的可重用cell id
private let retweetedCellId = "retweetedCellId"

class WBHomeViewController: WBBaseViewController {

    private lazy var listViewModel = WBStatusListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        //loadData()
        print("Home LoadData")
    }
    ///加载数据
    override func loadData() {
        //开始刷新的小菊花
        refreshControl?.beginRefreshing()
        
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
        
        //0. 取出视图模型 根据视图模型判断可重用cell
        let vm = listViewModel.statusList[indexPath.row]
        
        let cellId = (vm.status.retweeted_status != nil) ? retweetedCellId : originnalCellId
        
        // 1.   取cell
        //FIXME: - 修改id
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! WBStatusCell
        // 2.   设置cell
        cell.viewModel = vm
        
        
        
        //3.    返回cell
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        // 1 根据 indexpath设置视图模型
        let vm = listViewModel.statusList[indexPath.row]
        
        return vm.rowHeight
    }
    
}


///MARK: - 设置界面
extension WBHomeViewController {
    
    override func setupTalbeView() {
        super.setupTalbeView()
        //设置导航栏按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "好友", target: self, action: #selector(showFriends))
        
        //注册原型cell
        //tableView?.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        tableView?.register(UINib(nibName: "WBStatusNormalCell", bundle: nil), forCellReuseIdentifier: originnalCellId)
        
        tableView?.register(UINib(nibName: "WBStatusRetweetedCell", bundle: nil), forCellReuseIdentifier: retweetedCellId)
        
        //设置行高
        //取消自动行高
        //tableView?.rowHeight = UITableView.automaticDimension
        //预估行高
        tableView?.estimatedRowHeight = 300
        //取消分割线
        tableView?.separatorStyle = .none
        
        setupNavTitle()
    }
    
    private func setupNavTitle() {
        let title = WBNetworkManager.userAccount.screen_name
        let btn = WBTittleButton(title: title)
        navigationItem.titleView = btn
        btn.addTarget(self, action: #selector(clickTitleButton), for: .touchUpInside)
    }
    
    @objc func clickTitleButton(btn:UIButton) {
        //设置选中状态
        btn.isSelected = !btn.isSelected
        print(#function)
    }
}
