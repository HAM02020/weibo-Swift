//
//  MGRefreshView.swift
//  weibo
//
//  Created by 郝心如 on 2020/4/3.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit

///刷新视图
class MGRefreshView: UIView {
    
    ///刷新状态
    var refreshState: MGRefreshState = .Normal
    
    ///提示图标
    @IBOutlet weak var tipIcon: UIImageView!
    ///提示语
    @IBOutlet weak var tipLabel: UILabel!
    ///指示器
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    class func refreshView() -> MGRefreshView {
        let nib = UINib(nibName: "MGRefreshView", bundle: nil)
        
        return nib.instantiate(withOwner: nil, options: nil)[0] as! MGRefreshView
    }
}
