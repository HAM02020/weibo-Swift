//
//  WBUserAccount.swift
//  weibo
//
//  Created by 郝心如 on 2020/3/29.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit

private let accountFile = "userAccount.json"

///用户账户信息
class WBUserAccount: NSObject {
    
    @objc var access_token:String? //= "2.00S7fvUGniFLgDcd03b19156PB8cyD"
    
    @objc var uid : String?
    //过期日期
    //开发者5年
    //使用者3天
    @objc var expires_in:TimeInterval = 0 {
        didSet {
            expiresDate = Date(timeIntervalSinceNow: expires_in)
        }
    }
    
    @objc var expiresDate :Date?
    
    override var description: String {
        return yy_modelDescription()
    }
    
    override init() {
        super.init()
        
        //从磁盘加载保存的文件
        let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let filePath = (docDir as NSString).appendingPathComponent(accountFile)
        guard let data = NSData(contentsOfFile: filePath),
            let dict = try? JSONSerialization.jsonObject(with: data as Data, options: []) as? [String:AnyObject] else {
            return
        }
        yy_modelSet(with: dict )
        
        print("从沙盒取到的用户信息\(dict)")
        //expiresDate = Date(timeIntervalSinceNow: -3600 * 24 * 10)
        //  处理token过期
        if expiresDate?.compare(Date()) != ComparisonResult.orderedDescending {
            print("账户过期")
            
            //清空token
            access_token = nil
            uid = nil
            
            //删除账户文件
            _ = try? FileManager.default.removeItem(atPath: filePath)
        }
    }
    
    
    func saveAccount() {
        var dict = self.yy_modelToJSONObject() as? [String:AnyObject]  ?? [:]
        
        dict.removeValue(forKey: "expires_in")
        
        // 字典序列化
        
        guard let data =  try? JSONSerialization.data(withJSONObject: dict, options: [.prettyPrinted]) else {
            return
        }
        // 写入磁盘
        let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let filePath = (docDir as NSString).appendingPathComponent(accountFile)
        
        (data as NSData).write(toFile: filePath, atomically: true)
        print("用户账户保存z成功\(filePath)")
    }
}
