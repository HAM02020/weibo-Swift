//
//  WBNetworkManager+Extension.swift
//  weibo
//
//  Created by 郝心如 on 2020/3/28.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import Foundation

//MARK: - 封装新浪微博的网络请求方法
extension WBNetworkManager {
    
    
    /// 加载微博数据字典数组
    /// - Parameter completion: 完成回调[list: 微博字典数组/是否成功]
    func statusList(completion: @escaping(_ list:[[String:AnyObject]]?,_ isSuccess:Bool)->()) {
        
            //用网络工具加载微博数据
        let urlString = "https://api.weibo.com/2/statuses/home_timeline.json"
        let params = ["access_token":"2.00S7fvUGU1U7fEba8e1add890UizGg"]
        
        request(URLString: urlString, parameters: params) { (json, isSuccess) in
            let result = json?["statuses"] as? [[String:AnyObject]]
            
            completion(result,isSuccess)
//            result = result["statuses"] as! ([String : Any])

        }
        
        
    }
}
