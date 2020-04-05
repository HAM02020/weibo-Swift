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
    /// - Parameter since_id: 返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0
    /// - Parameter max_id: 则返回ID小于或等于max_id的微博，默认为0。
    /// - Parameter completion: 完成回调[list: 微博字典数组/是否成功]
    func getStatusList(since_id:Int64=0,max_id:Int64=0,completion: @escaping(_ list:[[String:AnyObject]]?,_ isSuccess:Bool)->()) {
        
            //用网络工具加载微博数据
        let urlString = "https://api.weibo.com/2/statuses/home_timeline.json"

        let params = ["since_id":"\(since_id)",
            "max_id":"\(max_id > 0 ? max_id - 1 : 0)"]
        
        tokenRequest(URLString: urlString, parameters: params as [String : AnyObject]) { (json, isSuccess) in
            let result = json?["statuses"] as? [[String:AnyObject]]
            
            completion(result,isSuccess)
//            result = result["statuses"] as! ([String : Any])

        }

    }
    
    //返回微博的未读数量
    func getUnreadCount(completion:@escaping (_ count:Int)->()) {
        
        guard let uid = WBNetworkManager.userAccount.uid else {
            return
        }
        
        let urlString = "https://rm.api.weibo.com/2/remind/unread_count.json"
        
        let pararms = ["uid":uid]
        
        tokenRequest(URLString: urlString, parameters: pararms as [String : AnyObject]) { (json, isSuccess) in
            
            let dict = json as? [String:AnyObject]
            let count = dict?["status"] as? Int
            completion(count ?? 0)
        
        }
    
    }

}

//MARK: - 发布微博
extension WBNetworkManager {
    
    ///发布微博
    func postStatus(text:String,completion:@escaping(_ result:[String:AnyObject]?,_ isSuccess:Bool)->())-> () {
        //1. url
        //let urlString = "http://api.sina.com.cn/2/statuses/update.json"
        let urlString = "https://api.weibo.com/2/statuses/share.json"
        //2. 参数字典
        //"source":WBAppKey,
        let params = ["status":text] as [String : AnyObject]
        
        //3.发起网络请求
        tokenRequest(method: .POST, URLString: urlString, parameters: params) { (json, isSuccess) in
            completion(json as? [String:AnyObject],isSuccess)
        }
        
        
    }
}


//MARK: - 用户信息
extension WBNetworkManager {
    
    func loadUserInfo(completion: @escaping(_ dict:[String:AnyObject])->()) {
        guard let uid = WBNetworkManager.userAccount.uid else {
            return
        }
        
        let urlString = "https://api.weibo.com/2/users/show.json"
        
        let pararms = ["uid":uid]
        
        //发起网络请求
        tokenRequest(URLString: urlString, parameters: pararms as [String : AnyObject]) { (json, isSuccess) in
            completion(json as?[String:AnyObject] ?? [:])
        }
    }
}

//OAuth相关方法
extension WBNetworkManager {
    /// 获取token
    /// - Parameters:
    ///   - code: 授权码
    ///   - completion: 完成回调[是否成功]
    func getAccessToken(code:String,completion: @escaping(_ isSuccess:Bool)->()) {
        let urlString = "https://api.weibo.com/oauth2/access_token"
        
        let pararms = ["client_id":WBAppKey,
                       "client_secret":WBAPPSecret,
                       "grant_type":"authorization_code",
                       "code":code,
                       "redirect_uri":WBRedirectURI]
        request(method: .POST, URLString: urlString, parameters: pararms as [String : AnyObject]) { (json, isSuccess) in
            print(json!)
            
            WBNetworkManager.self.userAccount.yy_modelSet(with: (json as? [String:AnyObject]) ?? [:])
            
            print(WBNetworkManager.self.userAccount)
            
            
            
            //加载当前用户信息
            self.loadUserInfo { (dict) in
                //加载完成再完成回调
                
                //使用用户信息字典设置用户账户信息
                WBNetworkManager.self.userAccount.yy_modelSet(with: dict)
                
                //保存模型
                WBNetworkManager.self.userAccount.saveAccount()
                completion(isSuccess)
            }
            
            
        }
    }
}
