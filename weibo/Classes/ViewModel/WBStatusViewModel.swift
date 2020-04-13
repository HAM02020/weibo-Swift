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
    
    @objc var picUrls : [WBStatusPicture]? {
        //如果有被转发的微博 返回被转发微博的配图，如果没有被转发的微博 返回 原创微博的配图 如果都没有 返回nil
        return status.retweeted_status?.pic_urls ?? status.pic_urls
    }
    ///微博正文属性文本
    @objc var statusAttrText :NSAttributedString?
    @objc var retweetedAttrText : NSAttributedString? //转发微博的文本
    
//    行高
    @objc var rowHeight:CGFloat = 0

    
    
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
        pictureViewSize = calcPictureViewSize(count: picUrls?.count)
        
        //设置微博文本
        let originalFont = UIFont.systemFont(ofSize: 15)
        let retweetedFont = UIFont.systemFont(ofSize: 14)
        
        //设置正文的属性文本
        statusAttrText = MGEmoticonManager.shared.emoticonString(string: model.text ?? "", font: originalFont)
        
        //设置被转发微博的文字
        let rText = "@\(status.retweeted_status?.user?.screen_name ?? ""):\(status.retweeted_status?.text ?? "")"
        retweetedAttrText = MGEmoticonManager.shared.emoticonString(string: rText, font: retweetedFont)
        
        
        
        //计算行高
        updateRowHeight()
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
    ///根据当前视图模型内容计算行高
    func updateRowHeight() {
        
        let margin :CGFloat = 12
        let iconHeight:CGFloat = 34
        let toolbarHeight:CGFloat = 35
        
        var height:CGFloat = 0
        let viewSize = CGSize(width: UIScreen.main.bounds.width - 2 * margin, height: CGFloat(MAXFLOAT))

        //1. 计算顶部位置
        height = 2 * margin + iconHeight + margin
        
        //2. 正文高度
        if let text = statusAttrText {
            
            height += text.boundingRect(with: viewSize, options: [.usesLineFragmentOrigin], context: nil).height
           
        }
        //3. 判断是否为转发微博
        if status.retweeted_status != nil {
            height += 2 * margin
            //转发文本的高度
            if let text = retweetedAttrText{
                
                height += text.boundingRect(with: viewSize, options: [.usesLineFragmentOrigin], context: nil).height
            }
        }
        //4.配图视图
        height += pictureViewSize.height
        
        height += margin
        
        height += toolbarHeight
        
        rowHeight = height
        
    }
    
    
    /// 使用单个图像 重新调整配图视图大小
    /// - Parameter image: 网络缓存的单张视图
    func updateSingleImageSize(image:UIImage) {
        var size = image.size
        
        //过宽图像处理
        let maxWidth : CGFloat = 200
        let minWidth : CGFloat = 40
        
        if size.width > maxWidth {
            //等比例调整高度
            size.width = maxWidth
            size.height = size.width * image.size.height / image.size.width
        }
        
        if size.width < minWidth {
            //等比例调整高度
            size.width = minWidth 
            size.height = size.width * image.size.height / image.size.width / 4
        }
        
        //过高图片处理
        if size.height > 200 {
            size.height = 200
        }
        
        size.height += outterMargin
        pictureViewSize = size
        
        //更新行高
        updateRowHeight()
    }
    
}
