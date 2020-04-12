//
//  MGEmoticon.swift
//  weibo
//
//  Created by 郝心如 on 2020/4/4.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit
import YYModel

class MGEmoticon: NSObject {
    
    ///表情类型 false - 图片表情。 true-emoji
    @objc var type = false
    ///表情字符串 发送给新浪微博服务
    @objc var chs:String?
    ///表情图片名称
    @objc var png:String?
    ///emoji的十六进制编码
    @objc var code:String?
    ///模型所在的目录
    @objc var directory:String?
    
    @objc var image:UIImage?{
        if type {
            return nil
        }
        guard let directory = directory,
            let png = png,
            let path = Bundle.main.path(forResource: "HMEmoticon.bundle", ofType: nil),
            let bundle = Bundle(path: path)
            else {
                    return nil
        }
        return UIImage(named: "\(directory)/\(png)",in: bundle,compatibleWith: nil)
        
    }
    
    @objc override var description: String {
        return yy_modelDescription()
    }
    
    ///将当前的图像转换生成图片的专属属性文本
    func imageText(font:UIFont) -> NSAttributedString {
        //1. 判断图片是否存在
        guard let image = image else {
            return NSAttributedString(string: "")
        }
        //2. 创建文本附件
        let attchment = NSTextAttachment()
        attchment.image = image
        let height = font.lineHeight
        attchment.bounds = CGRect(x: 0, y: -4, width: height, height: height)
        //3.返回图片属性文本
        return NSAttributedString(attachment: attchment)
        
    }
    
}


