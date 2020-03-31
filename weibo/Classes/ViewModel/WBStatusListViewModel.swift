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
///上拉刷新最大尝试次数
private let maxPullupTryTimes = 3

class WBStatusListViewModel {
    
    lazy var statusList = [WBStatusViewModel]()
    
    private var pullUpErrorTimes = 0
    
    /// 加载微博d列表
    /// - Parameter completion: 完成回调[网络请求是否成功]
    /// - Parameter isPullup: 是否上拉刷新
    func loadStatus(isPullup:Bool,completion:@escaping(_ isSuccess:Bool,_ shouldRefresh:Bool)->()) {
        
        //判断是否是上拉刷新，同时检查刷新错误
        if isPullup && pullUpErrorTimes > maxPullupTryTimes {
            completion(true,false)
            return
        }
        
        // since_id - q取出数组中的第一条微博的 id
        let since_id = isPullup ? 0 : statusList.first?.status.id ?? 0
        //上拉刷新取出 z数组最后一条微博的id
        let max_id = !isPullup ? 0 : (statusList.last?.status.id ?? 0)
        
        WBNetworkManager.shared().getStatusList(since_id:since_id,max_id: max_id) { (list, isSuccess) in
            //0. 判断网络是否成功
            if !isSuccess {
                completion(false,false)
                return
            }
            //print(list)
            //1. 字典转模型
            var array = [WBStatusViewModel]()
            
            //2> 便利服务器返回的字典数组，字典转模型
            for dict in list ?? [] {
                // a)  创建微博模型
                //或者 yy_modelSet(with :dict)
               
                guard let model = WBStatus.yy_model(with: dict) else {
                    continue
                }
                
                // b)将model添加到数组,转换成视图模型
                array.append(WBStatusViewModel(model: model))
            }
            
            print(array)
            print("刷新到\(array.count)条数据")
            
            //2. 拼接数据
            //FIXME:处理刷新
            if isPullup {
                self.statusList += array
            }else {
                //下拉刷新 结果放在数组前面
                self.statusList = array + self.statusList
            }
            
            //判断上拉刷新的数据量
            if isPullup && array.count == 0 {
                self.pullUpErrorTimes += 1
                completion(isSuccess,false)
            }else {
                completion(isSuccess,true)
            }
            
            
            
            
        }
    }
}
