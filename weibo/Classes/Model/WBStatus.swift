//
//  WBStatus.swift
//  weibo
//
//  Created by 郝心如 on 2020/3/29.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit
import YYModel

///微博数据模型
class WBStatus: NSObject {
    
    /// Int在64位机器是64位，在32位机器是32位
    var id:Int64 = 0
    //微博的内容
    var text :String?
    
    ///重写description 的计算型 属性
    override var description: String {
        return yy_modelDescription()
    }
    
}
