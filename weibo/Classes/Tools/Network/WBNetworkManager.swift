//
//  WBNetworkManager.swift
//  weibo
//
//  Created by 郝心如 on 2020/3/28.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit
import AFNetworking

enum WBHTTPMethod {
    case GET
    case POST
}

class WBNetworkManager: AFHTTPSessionManager {
    
    
    //lazy var userAccount = WBUserAccount()
    class var userAccount : WBUserAccount {
        return sharedAccount
    }
    
    /// 静态区 单l例
    static let shared = { () -> WBNetworkManager in
        
        let instance = WBNetworkManager()
            
        //响应反序列化支持的数据类型
        
        //instance.requestSerializer = AFJSONRequestSerializer()
        //instance.responseSerializer = AFHTTPResponseSerializer()
        instance.responseSerializer.acceptableContentTypes?.insert("text/plain")
        //instance.responseSerializer.acceptableContentTypes?.insert("application/json")
        //instance.responseSerializer.acceptableContentTypes?.insert("text/json")
        return instance
        
    }
    

    
    var userLogon :Bool {
        return WBNetworkManager.userAccount.access_token != nil
    }
    
    ///专门负责拼接 token 的网络请求方法
    func tokenRequest(method:WBHTTPMethod = .GET,URLString:String,parameters:[String:AnyObject]?,completion:@escaping( _ json:AnyObject?,_ isSuccess:Bool)->()) {
        
        //0>判断token是否为nil 如果为nil直接返回
        guard let token = WBNetworkManager.userAccount.access_token else {
            
            //FIXME: 发送通知 提醒用户登陆
            print("没有token 需要登陆！")
            
            NotificationCenter.default.post(name: NSNotification.Name(WBUserShouldLoginNotification), object: "bad token")
            
            completion(nil,false)
            return
        }
        
        //1> 判断参数字典是否存在，如果为nil 新建一个字典
        var parameters = parameters
        if parameters == nil {
            parameters = [String:AnyObject]()
        }
        
        //2> 设置参数字典
        parameters!["access_token"] = token as AnyObject
        
        //equest(URLString: URLString, parameters: parameters!, completion: completion)
        request(method: method, URLString: URLString, parameters: parameters!, completion: completion)
    }
    
    
    /// 使用一个函数封装 GET POST
    /// - Parameters:
    ///   - method: GET/POST
    ///   - URLString: URLString
    ///   - parameters: 参数字典
    ///   - completion: 完成回调[json(字典/数组),是否成功]
    func request(method:WBHTTPMethod = .GET,URLString:String,parameters:[String:AnyObject],completion:@escaping( _ json:AnyObject?,_ isSuccess:Bool)->()) {
    
        
        // 成功回调
        let success = {(task:URLSessionDataTask,json:Any?)->() in
            completion(json as AnyObject?,true)
        }
        
        //失败回调
        let failure = {(task:URLSessionDataTask?,error:Error)->() in
            
            //针对403 token过期 做处理
            if (task?.response as? HTTPURLResponse)?.statusCode == 403 {
                print("Token 过期了")
                
                //FIXME: 发送通知(本方法不知道被谁调用，谁接收到通知，谁处理)
                NotificationCenter.default.post(name: NSNotification.Name(WBUserShouldLoginNotification), object: "bad token")
            }
            
            print("网络请求错误\(error)")
            completion(nil,false)
        }
        
        if method == .GET {
            get(URLString, parameters: parameters, progress: nil, success: success, failure: failure)
        }else {
            post(URLString, parameters: parameters, progress: nil, success: success, failure: failure)
        }
 
    }
}
