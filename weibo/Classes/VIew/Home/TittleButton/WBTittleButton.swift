//
//  WBTittleButton.swift
//  weibo
//
//  Created by 郝心如 on 2020/3/30.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit

class WBTittleButton: UIButton {

//    重载构造函数
    init(title:String?) {
        super.init(frame: CGRect())
        
        if title == nil {
            setTitle("首页", for: [])
        }else {
            setTitle(title, for: [])
            
            setImage(UIImage(named: "navigationbar_arrow_down"), for: [])
            setImage(UIImage(named: "navigationbar_arrow_up"), for: .selected)
        }
        //设置字体和颜色
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        setTitleColor(UIColor.darkGray, for: [])
        
        
        sizeToFit()

        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //重新布局子视图
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let titleLabel = titleLabel,
            let imageView = imageView else {
                return
        }
        print("调整标题按钮布局")
        titleLabel.frame = CGRect(x: 0, y: 0, width: titleLabel.bounds.width, height: bounds.height)
        imageView.frame = CGRect(x: titleLabel.bounds.width, y: 0, width: imageView.bounds.width, height: bounds.height)
    }
}
