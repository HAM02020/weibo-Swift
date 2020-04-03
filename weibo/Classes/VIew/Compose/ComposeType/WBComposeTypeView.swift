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

    class func composeTypeView() -> WBComposeTypeView {
        let nib = UINib(nibName: "WBComposeTypeView", bundle: nil)
        let v = nib.instantiate(withOwner: nil, options: nil)[0] as! WBComposeTypeView
        v.frame = UIScreen.main.bounds
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
    
    override func awakeFromNib() {
        setupUI()
    }
    
    //MARK:监听方法
    @objc private func clickButton() {
        print("点我了")
    }
}


private extension WBComposeTypeView {
    func setupUI() {
        //创建类型按钮
        let btn = WBComposeTypeButton.composeTypeButton(imageName: "compose_message", title: "试一试")
        
        btn.center = center
        addSubview(btn)
        
//        添加监听方法
        btn.addTarget(self, action: #selector(clickButton), for: .touchUpInside)
    }
}
