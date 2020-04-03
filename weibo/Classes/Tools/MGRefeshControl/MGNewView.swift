//
//  MGNewView.swift
//  weibo
//
//  Created by 郝心如 on 2020/4/3.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit

class MGNewView: MGRefreshView {

    @IBOutlet weak var cloudIcon: UIImageView!
    
    @IBOutlet weak var earthIcon: UIImageView!
    
    @IBOutlet weak var humanIcon: UIImageView!
    
    override var parentViewHeight:CGFloat {
        didSet {
            print("父视图高度\(parentViewHeight)")
           
            if parentViewHeight < 108 {
                return
            }
            
            //高度差/最大高度差
            var scale : CGFloat
            if parentViewHeight > 188 {
                scale = 1
            }else {
                scale = 1 - (188 - parentViewHeight)/(188 - 20)
            }
            
            humanIcon.transform = CGAffineTransform(scaleX: scale, y: scale)
        }
    }
    
    override func awakeFromNib() {
        //1.  云
        //UIImage.animatedImage(with:[],duration:)可以几张图片循环播放
        //2.地球
        let anim = CABasicAnimation(keyPath: "transform.rotation")
        
        anim.toValue = -2 * Double.pi
        anim.repeatCount = MAXFLOAT
        anim.duration = 3
        
        anim.isRemovedOnCompletion = false
        
        earthIcon.layer.add(anim, forKey: nil)
        
        //设置锚点
        humanIcon.layer.anchorPoint = CGPoint(x: 0.5, y: 0.8)
        
        //设置center
        let x = self.bounds.width * 0.5
        let y = self.bounds.height - 20
        humanIcon.center = CGPoint(x: x, y: y)
        
        //外星人
        humanIcon.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
        
    }
}
