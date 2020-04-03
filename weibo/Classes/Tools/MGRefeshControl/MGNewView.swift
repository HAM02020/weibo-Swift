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
    
    override func awakeFromNib() {
        //1.  云
        
        //2.地球
        let anim = CABasicAnimation(keyPath: "transform.rotation")
        
        anim.toValue = -2 * Double.pi
        anim.repeatCount = MAXFLOAT
        anim.duration = 3
        
        anim.isRemovedOnCompletion = false
        
        earthIcon.layer.add(anim, forKey: nil)
    }
}
