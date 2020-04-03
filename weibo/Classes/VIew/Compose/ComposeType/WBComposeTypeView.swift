//
//  WBComposeType.swift
//  weibo
//
//  Created by 郝心如 on 2020/4/3.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit

/// 撰写微博 类型视图
class WBComposeTypeView: UIView {

    @IBOutlet weak var scrollView: UIScrollView!
    
    private let buttonInfo :[[String:String]] = [["imageName":"compose_message","title":"文字"],
                                            ["imageName":"compose_message","title":"照片/视频"],
                                            ["imageName":"compose_message","title":"长微博"],
                                            ["imageName":"compose_message","title":"签到"],
                                            ["imageName":"compose_message","title":"点评"],
                                            ["imageName":"compose_message","title":"更多"],
                                            ["imageName":"compose_message","title":"好友圈"],
                                            ["imageName":"compose_message","title":"微博相机"],
                                            ["imageName":"compose_message","title":"音乐"],
                                            ["imageName":"compose_message","title":"拍摄"],
                                                                            ]
                              
    
    class func composeTypeView() -> WBComposeTypeView {
        let nib = UINib(nibName: "WBComposeTypeView", bundle: nil)
        let v = nib.instantiate(withOwner: nil, options: nil)[0] as! WBComposeTypeView
        v.frame = UIScreen.main.bounds
        v.setupUI()
        return v
    }
    
    ///显示当前视图
    func show() {
        //1> 将当前视图添加到 跟视图控制器的view
        guard let vc = UIApplication.shared.keyWindow?.rootViewController else {
            return
        }
        vc.view.addSubview(self)
    }
    
    
    //MARK:监听方法
    @objc private func clickButton() {
        print("点我了")
    }
    
    @IBAction func close() {
        removeFromSuperview()
    }
    
    
}


private extension WBComposeTypeView {
    func setupUI() {
        
        //0. 强行更新布局
        layoutIfNeeded()
        
        //1. 向scrollView添加视图
        let rect = scrollView.bounds
        let v = UIView(frame: rect)
        //2. 向视图添加按钮
        addButtons(v: v, index: 0)
        
        //3. 将视图添加到scrollView
        scrollView.addSubview(v)
        
    }
    /// 向v 中添加按钮，索引从index开始
    /// - Parameters:
    ///   - v:
    ///   - index:开始位置
    func addButtons(v:UIView,index:Int){
        let count = 6
        
        for i in index...(index + count - 1) {
            
            if index >= buttonInfo.count {
                break
            }
            let dict = buttonInfo[i]
            guard let imageName = dict["imageName"],
                let title = dict["title"] else {
                    continue
            }
            
            let btn = WBComposeTypeButton.composeTypeButton(imageName: imageName, title: title)
            
            v.addSubview(btn)
        }
        
        //按钮布局
        
        //准备常量
        let btnSize = CGSize(width: 100, height: 100)
        let margin = (v.bounds.width - 3 * btnSize.width)/4
        for (i,btn) in v.subviews.enumerated() {
            print("iiiii = \(i)")
            let y :CGFloat = (i > 2) ? (v.bounds.height - btnSize.height) : 0
            let col = i % 3
            let x = CGFloat(col+1) * margin + CGFloat(col) * btnSize.width
            
            btn.frame = CGRect(x: x, y: y, width: btnSize.width, height: btnSize.height)
        }
    }
}
