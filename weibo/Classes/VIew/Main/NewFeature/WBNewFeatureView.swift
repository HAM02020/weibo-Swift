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
    
     //进入微博
    @IBAction func enterStatus() {
        removeFromSuperview()
    }
   
    
    
    class func newFeatureView() -> WBNewFeatureView {
        let nib = UINib(nibName: "WBNewFeatureView", bundle: nil)
        
        let v = nib.instantiate(withOwner: nil, options: nil)[0] as! WBNewFeatureView
        
        v.frame = UIScreen.main.bounds
        
        return v
    }
    
    override func awakeFromNib() {
        // 如果使用自动布局设置的界面 从XIB加载 默认是600 x 600
        //
        //添加4个图像视图
        let count = 3
        let rect = UIScreen.main.bounds
        
        for i in 0..<count {
            let imageName = "w\(i+1)"
            let iv = UIImageView(image: UIImage(named: imageName))
            
            //设置大小
            iv.frame = rect.offsetBy(dx: CGFloat(i)*rect.width, dy: 0)
            scrollView.addSubview(iv)
        }
        
        //指定scrollView的属性
        scrollView.contentSize = CGSize(width: CGFloat(count+1)*rect.width, height: rect.height)
        
        scrollView.bounces = false
        
        scrollView.isPagingEnabled = true
        
        scrollView.showsVerticalScrollIndicator = false
        
        scrollView.delegate = self
        //隐藏按钮
        enterButton.isHidden = true
    }
    
}

extension WBNewFeatureView:UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        //1. 滚动到最后一屏 让图像删除
        
        let page = Int(scrollView.contentOffset.x/scrollView.bounds.width)+1
        print(page)
        
        //2. 判断是否是最后一页
        if page == scrollView.subviews.count  {
            print("热烈欢迎")
            removeFromSuperview()
        }
        //3. 如果是倒数第二一 显示按钮
        enterButton.isHidden = (page != scrollView.subviews.count - 1)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        //  0.一旦滚动隐藏按钮
        enterButton.isHidden = true
        //  1.计算当前的偏移量
        let page = Int(scrollView.contentOffset.x/scrollView.bounds.width+0.5)
        
        //2. 设置分页 控件
        pageControl.currentPage = page
        
        //3. 分页控件隐藏
        pageControl.isHidden = (page == scrollView.subviews.count)
    }
}
