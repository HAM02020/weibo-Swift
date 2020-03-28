//
//  WBStatusListViewModel.swift
//  weibo
//
//  Created by 郝心如 on 2020/3/29.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import Foundation

/// 微博数据列表视图模型
/// 父类的选择

/*
 使命 ：负责微博的数据处理
    1. 字典转模型
    2. 下拉/上拉刷新数据处理
 */
class WBStatusListViewModel {
    lazy var statusList = [WBStatus]()
    
    
    /// 加载微博d列表
    /// - Parameter completion: 完成回调[网络请求是否成功]
    func loadStatus(completion:@escaping(_ isSuccess:Bool)->()) {
        WBNetworkManager.shared.statusList { (list, isSuccess) in
            
            //1. 字典转模型
            guard let array = NSArray.yy_modelArray(with: WBStatus.self, json: list ?? []) as? [WBStatus] else {
                completion(false)
                return
            }
            
            //2. 拼接数据
            self.statusList += array
            completion(true)
            
        }
    }
}
