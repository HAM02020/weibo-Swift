//
//  WBNetworkManager.swift
//  weibo
//
//  Created by 郝心如 on 2020/3/28.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit
import AFNetworking
class WBNetworkManager: AFHTTPSessionManager {
    
    /// 静态区 单l例
    static let shared = WBNetworkManager()
}
