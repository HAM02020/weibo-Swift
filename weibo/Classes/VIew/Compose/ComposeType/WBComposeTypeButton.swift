//
//  WBComposeTypeButton.swift
//  weibo
//
//  Created by 郝心如 on 2020/4/3.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit

class WBComposeTypeButton: UIControl {

    @IBOutlet weak var imageView: UIImageView?
    
    @IBOutlet weak var titleLabel: UILabel?
    
    //要展现的控制器类型
    var clsName : String?
    
    
    /// 使用图像名称 标题创建按钮
    /// - Parameters:
    ///   - imageName:
    ///   - title:
    class func composeTypeButton(imageName:String,title:String)->WBComposeTypeButton {
        let nib = UINib(nibName: "WBComposeTypeButton", bundle: nil)
        let btn = nib.instantiate(withOwner: nil, options: nil)[0] as! WBComposeTypeButton

        btn.imageView?.image = UIImage(named: imageName)
        btn.titleLabel?.text = title
        
        return btn
    }
}
