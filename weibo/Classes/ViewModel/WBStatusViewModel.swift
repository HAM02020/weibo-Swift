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
        
    }
    //相当于toString？
    var description: String {
        return status.description
    }
}
