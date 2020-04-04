//
//  MGEmoticonManager.swift
//  weibo
//
//  Created by 郝心如 on 2020/4/4.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit

class MGEmoticonManager {
    
    static let shared = MGEmoticonManager()
    
    lazy var packages = [MGEmoticonPackage]()
    
    private init() {
        loadPackages()
    }
    
    
    
}

//MARK:  - 表情包数据处理

private extension MGEmoticonManager {
    func loadPackages() {
        
        //读取emoticons.plist
        guard let path = Bundle.main.path(forResource: "HMEmoticon.bundle", ofType: nil),
            let bundle = Bundle(path: path),
            let plistPath = bundle.path(forResource: "emoticons.plist", ofType: nil),
            let array = NSArray(contentsOfFile: plistPath) as? [[String:String]],
            let models = NSArray.yy_modelArray(with: MGEmoticonPackage.self, json: array) as? [MGEmoticonPackage]
                else {
                return
        }
        
        packages += models
        
        print("loadPackage\(array)")
    }
}


