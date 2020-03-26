//
//  UIButton+Extensions.swift
//  weibo-11.0
//
//  Created by 郝心如 on 2020/3/26.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit

extension UIButton {
    
    class func creatTextButton(title: String , colornormal: UIColor , colorhighligh :UIColor) -> UIButton {
        let btn : UIButton = UIButton()
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(colornormal, for: .normal)
        btn.setTitleColor(colorhighligh, for: .highlighted)
//        btn.addTarget(self, action: #selector(showNext), for: .touchUpInside)
        return btn
    }
    
}
