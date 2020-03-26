//
//  UIBarButtonItem+Extensions.swift
//  weibo-11.0
//
//  Created by 郝心如 on 2020/3/26.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    convenience init(title:String,target:AnyObject?,action:Selector){
        let btn = UIButton.creatTextButton(title: title, colornormal: UIColor.gray, colorhighligh: UIColor.orange)
        btn.addTarget(target, action: action, for: .touchUpInside)
        self.init(customView: btn)
        
    }
}
