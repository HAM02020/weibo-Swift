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

//MARK: - 表情符号处理
extension MGEmoticonManager {
    
    ///将给定字符串转换成 属性文本
    func emoticonString (string:String,font:UIFont)->NSAttributedString {
        let attrString = NSMutableAttributedString(string: string)
        
        //1.建立正则表达式 过滤所有表情文字
        let patter = "\\[.*?\\]"
        guard let regx = try? NSRegularExpression(pattern: patter, options: []) else {
            return attrString
        }
        let matches = regx.matches(in: string, options: [], range: NSRange(location: 0, length: attrString.length))
        
        //3.遍历所有结果 注意这里要倒叙便利 因为替换属性文本 会改变后面字符串的索引
        for m in matches.reversed() {
            
            let r = m.range(at: 0)
            
            let subStr = (attrString.string as NSString).substring(with: r)
            
            //1> 使用 subStr 查找对应表情符号
            if let em = MGEmoticonManager.shared.findEmoticon(string: subStr){
                //2>使用 表情符号中的属性文本替换
                attrString.replaceCharacters(in: r, with: em.imageText(font: font))
            }
            
        }
        //4. 统一设置一遍字符串的属性
        attrString.addAttributes([NSAttributedString.Key.font:font], range: NSRange(location: 0, length: attrString.length))
        return attrString
    }
    
    /// 根据string在所有表情符号中查找对应的表情模型对象
    /// - Parameter string: 名
    func findEmoticon(string:String) -> MGEmoticon? {
        
        //1.。表里表情包
        
        for p in packages {
            
            //2. 在表情包中过滤string
            //方法1 尾随闭包
//            let result = p.emoticons.filter { (em) -> Bool in
//                return em.chs == string
//            }
            //方法2
            //参数省略后可以用 $0,$1代替原来的参数
            let result = p.emoticons.filter {return $0.chs == string }
            
            //根据数量判断结果
            if result.count == 1 {
                return result[0]
            }
        }
        return nil
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


