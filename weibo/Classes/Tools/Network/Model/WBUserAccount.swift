//
//  WBUserAccount.swift
//  weibo
//
//  Created by 郝心如 on 2020/3/29.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit

///用户账户信息
class WBUserAccount: NSObject {
    
    @objc var access_token:String?
    
    @objc var uid : String?
    //过期日期
    //开发者5年
    //使用者3天
    @objc var expires_in:TimeInterval = 0
    
    override var description: String {
        return yy_modelDescription()
    }
}
