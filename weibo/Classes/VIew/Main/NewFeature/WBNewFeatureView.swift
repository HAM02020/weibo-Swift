//
//  WBNewFeatureView.swift
//  weibo
//
//  Created by 郝心如 on 2020/3/30.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit

class WBNewFeatureView: UIView {

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var enterButton: UIButton!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBAction func enterStatus() {
    }
    //进入微博
    override init(frame: CGRect) {
        super.init(frame:frame)
        
        backgroundColor = UIColor.orange
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
