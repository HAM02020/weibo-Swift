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
    
    /// 静态区 单l例
    static let shared = WBNetworkManager()
    
    ///访问令牌。有时限
    var accessToken:String? = "2.00S7fvUGniFLgDaf931b7642dfht9E"
    
    ///用户微博 id
    var uid : String? = "5953831002"
    
    ///专门负责拼接 token 的网络请求方法
    func tokenRequest(method:WBHTTPMethod = .GET,URLString:String,parameters:[String:AnyObject]?,completion:@escaping( _ json:AnyObject?,_ isSuccess:Bool)->()) {
        
        //0>判断token是否为nil 如果为nil直接返回
        guard let token = accessToken else {
            
            //FIXME: 发送通知 提醒用户登陆
            print("没有token 需要登陆！")
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
        
        request(URLString: URLString, parameters: parameters!, completion: completion)
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
