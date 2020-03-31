//
//  WBStatusViewModel.swift
//  weibo
//
//  Created by 郝心如 on 2020/3/31.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import Foundation

///单条微博的视图模型
class WBStatusViewModel {
   @objc var status: WBStatus
    
    init(model:WBStatus) {
        self.status = model
    }
}
