//
//  String+Extensions.swift
//  weibo
//
//  Created by 郝心如 on 2020/4/4.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import Foundation

extension String {
    
    //从当前字符串中提取链接和文本
    func mg_href () -> (link:String,text:String)? {
        let pattern = "<a href=\"(.*?)\".*?>(.*?)</a>"
        guard let regx = try? NSRegularExpression(pattern: pattern, options: []) ,
            let result = regx.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.count)) else {
            return nil
        }
        let link = (self as NSString).substring(with: result.range(at: 1))
        let text = (self as NSString).substring(with: result.range(at: 2))
        
        print(link + "----" + text)
        
        return(link,text)
        
    }
    
}
