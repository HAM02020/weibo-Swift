//
//  Date+Extensions.swift
//  weibo
//
//  Created by 郝心如 on 2020/4/13.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import Foundation

///日期格式化器 不要频繁的释放g和创建 会影响性能
private let dateFormatter = DateFormatter()
///当前日历对象
private let calendar = Calendar.current
extension Date {
    
    static func mg_dateString(delta: TimeInterval)->String {
        
        let date = Date(timeIntervalSinceNow: delta)
        
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        return dateFormatter.string(from: date)
    }
    
    static func mg_sinaDate(string:String)-> Date? {
        dateFormatter.dateFormat = "EEE MMM dd HH:mm:ss zzz yyyy"
        
        return dateFormatter.date(from: string)
    }
    
    var mg_dateDescription:String {
        
        if calendar.isDateInToday(self) {
            
            let delta = -Int(self.timeIntervalSinceNow)
            
            if delta < 60 {
                return "刚刚"
            }
            
            if delta < 3600 {
                return "\(delta / 60)分钟前"
            }
            
            return "\(delta / 3600)小时前"
        }
        //其它天
        var fmt = " HH:mm"
        if calendar.isDateInYesterday(self) {
            fmt = "昨天" + fmt
        }else {
            fmt = "MM-dd" + fmt
            
            let year = calendar.component(.year, from: self)
            let thisyear = calendar.component(.year, from: Date())
            
            if year == thisyear {
                fmt = "yyyy-" + fmt
            }
        }
        
        // 设置日期格式字符串
        dateFormatter.dateFormat = fmt
        
        return dateFormatter.string(from: self)
    }
}
