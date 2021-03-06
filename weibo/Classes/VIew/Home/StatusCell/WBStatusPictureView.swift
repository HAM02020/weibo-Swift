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
                
                //判断是否是gif
                iv.subviews[0].isHidden = (((url.thumbnail_pic ?? "") as NSString).pathExtension.lowercased() != "gif")
                    
                
                
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
    
    //MARK: - 监听方法
    @objc func tapImageView(tap:UITapGestureRecognizer) {
        guard
            let iv = tap.view,
            let picUrls = viewModel?.picUrls
        else {
            return
        }
        var selectedIndex = iv.tag
        
        //针对4张图处理
        if picUrls.count == 4 && selectedIndex > 1{
            selectedIndex -= 1
        }
        //改成largePic 查看大图
        let urls = (picUrls as NSArray).value(forKey: "largePic") as! [String]
        
        //处理可见的图像视图数组
        var imageViewList = [UIImageView]()
        
        for iv in subviews {
            if !iv.isHidden {
                imageViewList.append(iv as! UIImageView)
            }
        }
        
        //发送通知
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: WBStatusCellBrowserPhotoNotification), object: self, userInfo: [WBStatusCellBrowserSelectedIndexKey:selectedIndex
            ,WBStatusCellBrowserPhotoUrlsKey:urls
            ,WBStatusCellBrowserPhotoImageViewsKey:imageViewList])
        
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
            
            //让imageviewn能够接受用户交互
            iv.isUserInteractionEnabled = true
            
            //添加手势识别
            let tap = UITapGestureRecognizer(target: self, action: #selector(tapImageView))
            
            iv.addGestureRecognizer(tap)
            
            //设置imageView的tag
            iv.tag = i
            //向图像视图添加gif提示t图像
            addGifView(iv: iv)
        }
    }
    private func addGifView(iv:UIImageView){
        
        let gif = UIImageView(image: UIImage(named: "status_gif"))
        iv.addSubview(gif)
        
        //自动布局
        gif.translatesAutoresizingMaskIntoConstraints = false
        
        iv.addConstraint(NSLayoutConstraint(item: gif,
                                            attribute: .right,
                                            relatedBy: .equal,
                                            toItem: iv,
                                            attribute: .right,
                                            multiplier: 1.0,
                                            constant: 0))
        iv.addConstraint(NSLayoutConstraint(item: gif,
                                            attribute: .bottom,
                                            relatedBy: .equal,
                                            toItem: iv,
                                            attribute: .bottom,
                                            multiplier: 1.0,
                                            constant: 0))

    }
}
