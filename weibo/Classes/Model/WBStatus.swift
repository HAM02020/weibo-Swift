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
    ///!!!!!!!!!!!!!!!!!!!!!!!!!!!!!一定要在属性上 加 @objc 不然 无法识别！！！！！！！！！！！！！！！！！！！！
    @objc var id:Int64 = 0
    //微博的内容
    @objc var text : String?
    //微博创建时间字符串
    @objc var created_at:String?
    //微博来源 客户端 设备
    @objc var source:String?
    
    
    /// 转发 评论 点赞 数
    @objc var reposts_count : Int = 0
    @objc var comments_count :Int = 0
    @objc var attitudes_count :Int = 0
    
    @objc var user: WBUser?
    
    @objc var pic_urls:[WBStatusPicture]?
    
    //被转发的原创微博
    @objc var retweeted_status:WBStatus?
    
    ///重写description 的计算型 属性
    override var description: String {
        return yy_modelDescription()
    }
    //类函数 告诉 yy model 遇到数组类型的属性 数组中存放的对象是什么类
    @objc class func modelContainerPropertyGenericClass() -> [String:AnyClass]{
        return ["pic_urls":WBStatusPicture.self]
    }
}
