//
//  UIBarButtonItem+Extensions.swift
//  weibo-11.0
//
//  Created by 郝心如 on 2020/3/26.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    convenience init(title:String,target:AnyObject?,action:Selector,isBack:Bool = false){
        let btn = UIButton.creatTextButton(title: title, colornormal: UIColor.systemGray, colorhighligh: UIColor.orange)
        
        if(isBack) {
            let imageName = "back"
            btn.setImage(UIImage(named: imageName), for: .normal)
            btn.setImage(UIImage(named: imageName+"_highlighted"), for: .highlighted)
        }
        
        btn.addTarget(target, action: action, for: .touchUpInside)
        self.init(customView: btn)
        
    }
}
