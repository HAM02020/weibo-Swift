//
//  WBStatusListDAL.swift
//  weibo
//
//  Created by 郝心如 on 2020/4/13.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import Foundation

///DAL -- 数据访问层
///使命：负责 处理数据库和网络数据 给ListViewModel 返回微博的字典数组
class WBStatusListDAL {
    
    /// 从本地数据库 或者 网络加载数据
    /// - Parameters:
    ///   - since_id: 下拉
    ///   - max_id: 上拉
    ///   - completion: 完成回调（微博的字典数组）
    class func loadStatus(since_id:Int64 = 0,max_id:Int64 = 0,completion: @escaping(_ list:[[String:AnyObject]]?,_ isSuccess:Bool)->()) {
        
        //0. 获取用户代号
        guard let userId = WBNetworkManager.userAccount.uid else {
            return
        }
        //1. 检查本地数据 如果有 直接返回
        let array = MGSQLiteManager.shared.loadStatus(userId: userId, since_id: since_id, max_id: max_id)
        
        //  判断数组的数量
        if array.count > 0 {
            completion(array,true)
            return
        }
        //2. 加载网络数据
        WBNetworkManager.shared().getStatusList(since_id: since_id, max_id: max_id) { (list, isSuccess) in
            //判断网络请求是否成功
            if !isSuccess {
                completion(nil,false)
                return
            }
            
            //判断数据
            guard let list = list else {
                completion(nil,isSuccess)
                return
            }
            //3. 加载完成后， 将网络数据 写入数据库
            MGSQLiteManager.shared.updateStatus(userId: userId, array: list)
            //4. 返回网络数据
            completion(list,isSuccess)
        }
        
        
        
        
    }
}
