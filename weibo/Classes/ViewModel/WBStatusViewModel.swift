//
//  WBStatusViewModel.swift
//  weibo
//
//  Created by 郝心如 on 2020/3/31.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit

///单条微博的视图模型
class WBStatusViewModel :CustomStringConvertible{
    @objc var status: WBStatus
    
    @objc var memberIcon : UIImage?
    
    @objc var vipIcon:UIImage?
    
    ///转发文字
    @objc var retweedtedStr : String?
    ///评论文字
    @objc var commentStr : String?
    ///点赞文字
    @objc var likeStr : String?
    
    
    init(model:WBStatus) {
        self.status = model
        
        if model.user!.mbrank > 0 && model.user!.mbrank < 7 {
            let imageName = "cell_crown"
            memberIcon = UIImage(named: imageName)
        }
        
        //认证图标
        switch model.user?.verified_type ?? -1 {
        case 0:
            vipIcon = UIImage(named: "cell_VIP")
        case 2,3,5:
        vipIcon = UIImage(named: "cell_enterprise_vip")
        case 220:
        vipIcon = UIImage(named: "cell_grassroot")
        default:
            break
        }
        //设置底部计数字符串
        retweedtedStr = countStr(count: model.reposts_count, defaultStr: "转发")
        commentStr = countStr(count: model.comments_count, defaultStr: "评论")
        likeStr = countStr(count: model.attitudes_count, defaultStr: "赞")
        
        
    }
    
    /// 给定一个数字返回对应的描述结果
    /// - Parameters:
    ///   - count: 数字
    ///   - defaultStr: 默认字符串
    private func countStr(count:Int,defaultStr:String) -> String {
        if count == 0 {
            return defaultStr
        }
        if count < 10000 {
            return count.description
        }
        return String(format: "%.02f 万", Double(count/10000))
    }
    
    //相当于toString？
    var description: String {
        return status.description
    }
}
