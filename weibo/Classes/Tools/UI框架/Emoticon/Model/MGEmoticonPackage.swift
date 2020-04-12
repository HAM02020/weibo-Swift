//
//  MGEmoticonPackage.swift
//  weibo
//
//  Created by 郝心如 on 2020/4/4.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit
import YYModel

class MGEmoticonPackage: NSObject {

    ///表情包的分组名
    @objc var groupName:String?
    ///表情包目录，从目录下加载info.plist 可以创建表情模型数组
    @objc var directory:String? {
        didSet {
            guard let directory = directory,
                let path = Bundle.main.path(forResource: "HMEmoticon.bundle", ofType: nil),
                let bundle = Bundle(path: path),
                let infoPath = bundle.path(forResource: "info.plist", ofType: nil,inDirectory: directory),
                let array = NSArray(contentsOfFile: infoPath) as? [[String:String]],
                let models = NSArray.yy_modelArray(with: MGEmoticon.self, json: array) as? [MGEmoticon]
            else {
                return
            }
            //遍历models数组,设置每一个表情符号的目录
            for m in models {
                m.directory = directory
            }
            emoticons += models
            
        }
    }
    ///表情模型的空数组
    @objc lazy var emoticons = [MGEmoticon]()
    
    @objc override var description: String {
        return yy_modelDescription()
    }
}
