//
//  WBUser.swift
//  weibo
//
//  Created by 郝心如 on 2020/3/31.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit


///微博用户模型
class WBUser: NSObject {

    @objc var id : Int64 = 0
    ///昵称
    @objc var screen_name : String?
    ///头像 50 50
    @objc var profile_image_url : String?
    ///d认证等级。-1 五认证。235 认证用户 220 达人
    @objc var verified_type:Int = 0
    ///会员等级 0 - 6
    @objc var mbrank : Int = 0
}
