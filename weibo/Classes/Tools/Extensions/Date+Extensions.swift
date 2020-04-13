//
//  Date+Extensions.swift
//  weibo
//
//  Created by 郝心如 on 2020/4/13.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import Foundation

///日期格式化器 不要频繁的释放g和创建 会影响性能
let dateFormatter = DateFormatter()

extension Date {
    
    static func mg_dateString(delta: TimeInterval)->String {
        
        let date = Date(timeIntervalSinceNow: delta)
        
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        return dateFormatter.string(from: date)
    }
}
