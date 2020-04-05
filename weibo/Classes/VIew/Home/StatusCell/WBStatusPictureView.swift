//
//  WBStatusPictureView.swift
//  weibo
//
//  Created by 郝心如 on 2020/4/1.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit

class WBStatusPictureView: UIView {

    var viewModel:WBStatusViewModel? {
        didSet {
            clacViewSize()
        }
    }
    
    //根据配图视图模型的配图大小设置图像大小
    private func clacViewSize() {
        //处理宽度
        // 1 > 单图
        if viewModel?.picUrls?.count == 1 {
            let viewSize = viewModel?.pictureViewSize ?? CGSize()
            let iv = subviews[0]
            iv.frame = CGRect(x: 0, y: outterMargin, width: viewSize.width, height: viewSize.height - outterMargin)
        }else {
            //2> 多图(无图)，恢复 subview[0]的宽高
            let iv = subviews[0]
            iv.frame = CGRect(x: 0, y: outterMargin, width: itemWidth, height: itemWidth)
        }
        heightCons.constant = viewModel?.pictureViewSize.height ?? 0
    }
    
    
    @objc var urls:[WBStatusPicture]? {
        didSet {
            //1.隐藏所有的imageview
            for v in subviews {
                v.isHidden = true
            }
            
            //  遍历url数组
            var index = 0
            
            for url in urls ?? []{
                print("url.thumpic = \(String(describing: url.thumbnail_pic))")
                
                //获取对应索引的imageView
                let iv = subviews[index] as! UIImageView
                
                //4张图像处理
                if index == 1 && urls?.count == 4 {
                    index += 1
                }
                
                
                //设置图像
                iv.mg_setImage(urlString: url.thumbnail_pic, placeholderImage: nil)
                iv.contentMode = .scaleAspectFill
                iv.clipsToBounds = true
                //  显示图像
                iv.isHidden = false
                index += 1
            }
        }
    }
    
    @IBOutlet weak var heightCons:NSLayoutConstraint!
    
    override func awakeFromNib() {
        setupUI()
    }
    
}

extension WBStatusPictureView {
    ///Cell 中所有的控件提前准备好
    ///根据数据是否显示
    
    
    
    private func setupUI() {
        
        //设置背景颜色
        backgroundColor = superview?.backgroundColor
        
        let rect = CGRect(x: 0, y: outterMargin, width: itemWidth, height: itemWidth)
        
        //超出边界的内容不显示
        clipsToBounds = true
        //isUserInteractionEnabled = false
        //循环创建 9 个imageView
        for i in 0..<9 {
            let iv = UIImageView()
            
            //行
            let row = CGFloat(i/3)
            //列
            let col = CGFloat(i%3)

            let xOffset = col * (itemWidth + innerMargin)
            let yOffset = row * (itemWidth + innerMargin)
            
            iv.frame = rect.offsetBy(dx: xOffset, dy: yOffset)
            
            addSubview(iv)
        }
    }
}
