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
        
        //1. 检查本地数据 如果有 直接返回
        
        //2. 加载网络数据
        
        //3. 加载完成后， 将网络数据 写入数据库
        
        //4. 返回网络数据
        
    }
}
