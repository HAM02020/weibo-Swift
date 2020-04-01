//
//  WBStatusViewModel.swift
//  weibo
//
//  Created by 郝心如 on 2020/3/31.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit


//外侧间距
let outterMargin :CGFloat = 12
//内部视图的间距
let innerMargin:CGFloat = 3
//视图的宽度
let pictureWidth = UIScreen.main.bounds.width - 2*outterMargin
//每个item默认的宽度
let itemWidth = (pictureWidth - 2*innerMargin)/3


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
    //  配图大小
    @objc var pictureViewSize = CGSize()
    
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
        
        //计算配图视图大小
        pictureViewSize = calcPictureViewSize(count: status.pic_urls!.count)
        
    }
    
    
    
    private func calcPictureViewSize(count:Int?) -> CGSize {
        
        if count == 0 || count == nil{
            return CGSize()
            
        }
        
        
        //2. 计算高度
        // 1. 根据count计算行数
        let row = (count!-1)/3+1
        //2>   根据行数计算高度
        var height = outterMargin
            height += CGFloat(row) * itemWidth
            height += CGFloat(row-1) * innerMargin
        
        
        return CGSize(width: pictureWidth, height: height)
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
