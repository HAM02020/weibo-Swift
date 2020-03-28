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
    
    /// 使用一个函数封装 GET POST
    /// - Parameters:
    ///   - method: GET/POST
    ///   - URLString: URLString
    ///   - parameters: 参数字典
    ///   - completion: 完成回调[json(字典/数组),是否成功]
    func request(method:WBHTTPMethod = .GET,URLString:String,parameters:[String:Any],completion:@escaping( _ json:Any?,_ isSuccess:Bool)->()) {
        
        // 成功回调
        let success = {(task:URLSessionDataTask,json:Any?)->() in
            completion(json,true)
        }
        
        //失败回调
        let failure = {(task:URLSessionDataTask?,error:Error)->() in
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
