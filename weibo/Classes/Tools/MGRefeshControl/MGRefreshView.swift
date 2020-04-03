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
    //如果想实现 360 旋转 需要核心动画 CABaseAnimation
    var refreshState: MGRefreshState = .Normal {
        didSet {
            switch refreshState {
            case .Normal:
                tipLabel.text = "继续使劲拉..."
                //回复箭头初始状态
                UIView.animate(withDuration: 0.25) {
                    self.tipIcon.transform = CGAffineTransform.identity
                }
                
            case .Pulling:
                tipLabel.text = "放手刷新..."
                
                UIView.animate(withDuration: 0.25) {
                    self.tipIcon.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi + 0.001)) ///减去一点点 实现同方向 而不是顺时针旋转 就近原则
                }
                
                
            case .WillRefresh:
                tipLabel.text = "正在刷新中..."
                tipIcon.isHidden = true
                
                //显示菊花
                indicator.startAnimating()
            }
        }
    }
    
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
