//
//  WBWelcomeView.swift
//  weibo
//
//  Created by 郝心如 on 2020/3/30.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit
import SDWebImage
class WBWelcomeView: UIView {

    @IBOutlet weak var iconView: UIImageView!
    
    @IBOutlet weak var tipLabel: UILabel!
    
    @IBOutlet weak var boottomLab: NSLayoutConstraint!
    class func welcomeView() -> WBWelcomeView {
        let nib = UINib(nibName: "WBWelcomeView", bundle: nil)
        
        let v = nib.instantiate(withOwner: nil, options: nil)[0] as! WBWelcomeView
        
        v.frame = UIScreen.main.bounds
        
        return v
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        //  提示: initWithcode 只是刚刚从XIB的二进制文件将视图加载完成
        //还没有和代码连线建立起关系，所以开发时千万不要在这个方法中处理UI
    }
    
    override func awakeFromNib() {
        
        //1. url
        guard let urlString = WBNetworkManager.userAccount.avatar_large,
            let url = URL(string: urlString) else {
            return
        }
        
        //2. 设置头像 - 如果网络没有下载完成，先显示展位图像
        //如果不指定占位图像 之前设置的图像会被清空
        iconView.sd_setImage(with: url, placeholderImage: UIImage(named: "Avatar"))
        
        //3. 设置圆角
        iconView.layer.cornerRadius = iconView.bounds.width * 0.5
        iconView.layer.masksToBounds = true
        
            
    }
    
    //视图被放到window上
    override func didMoveToWindow() {
        super.didMoveToWindow()
        
        self.layoutIfNeeded()
        boottomLab.constant = bounds.size.height - 400
        
        UIView.animate(withDuration: 2,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0,
                       options: [],
                       animations: {
                        
                        //更新约束
                        self.layoutIfNeeded()
                        
        }) { (_) in
            UIView.animate(withDuration: 1,
                           delay: 0,
                           usingSpringWithDamping: 0.7,
                           initialSpringVelocity: 0,
                           options: [],
                           animations: {
                            self.tipLabel.alpha = 1
            }) { (_) in
                self.removeFromSuperview()
            }
        }
    }
    
}
