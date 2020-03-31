//
//  WBStatusPicture.swift
//  weibo
//
//  Created by 郝心如 on 2020/4/1.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit

class WBStatusPicture: NSObject {

    ///缩略图地址
    @objc var thumbnail_pic : String?
    
    override var description: String{
        return yy_modelDescription()
    }
    
}
