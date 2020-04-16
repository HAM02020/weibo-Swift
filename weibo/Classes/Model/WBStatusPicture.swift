//
//  WBStatusPicture.swift
//  weibo
//
//  Created by 郝心如 on 2020/4/1.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit

class WBStatusPicture: NSObject {
    
    //大尺寸图片
    @objc var largePic:String?
    ///缩略图地址
    @objc var thumbnail_pic : String? {
        didSet {
            //print("缩略图地址 = \(thumbnail_pic)")
            //更改缩略图地址
            thumbnail_pic = thumbnail_pic?.replacingOccurrences(of: "/thumbnail/", with: "/wap360/")
            
            //设置大尺寸图片
            largePic = thumbnail_pic?.replacingOccurrences(of: "/wap360/", with: "/large/")
        }
    }
    
    
    override var description: String{
        return yy_modelDescription()
    }
    
}
