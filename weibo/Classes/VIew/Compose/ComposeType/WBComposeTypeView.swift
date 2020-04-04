//
//  WBComposeType.swift
//  weibo
//
//  Created by 郝心如 on 2020/4/3.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit
import pop
/// 撰写微博 类型视图
class WBComposeTypeView: UIView {

    @IBOutlet weak var scrollView: UIScrollView!
    ///关闭按钮的x
    @IBOutlet weak var closeButtonCenterX: NSLayoutConstraint!
    ///返回按钮的x
    @IBOutlet weak var returnButtonCenterX: NSLayoutConstraint!
    
    @IBOutlet weak var returnButton: UIButton!
    
    private let buttonInfo = [["imageName":"compose_message","title":"文字","clsName":"WBComposeViewController"],
                                            ["imageName":"compose_message","title":"照片/视频"],
                                            ["imageName":"compose_message","title":"长微博"],
                                            ["imageName":"compose_message","title":"签到"],
                                            ["imageName":"compose_message","title":"点评"],
                                            ["imageName":"compose_message","title":"更多","action":"clickMore"],
                                            ["imageName":"compose_message","title":"好友圈"],
                                            ["imageName":"compose_message","title":"微博相机"],
                                            ["imageName":"compose_message","title":"音乐"],
                                            ["imageName":"compose_message","title":"拍摄"],
                                                                            ]
     
    private var completionBlock:((_ clsName:String?)->())?
    
    //MARK: - 实例化方法
    class func composeTypeView() -> WBComposeTypeView {
        let nib = UINib(nibName: "WBComposeTypeView", bundle: nil)
        let v = nib.instantiate(withOwner: nil, options: nil)[0] as! WBComposeTypeView
        v.frame = UIScreen.main.bounds
        v.setupUI()
        return v
    }
    
    ///显示当前视图
    func show(completion :@escaping (_ clsName:String?)->()) {
        //0.记录闭包
        completionBlock = completion
        
        //1> 将当前视图添加到 跟视图控制器的view
        guard let vc = UIApplication.shared.keyWindow?.rootViewController else {
            return
        }
        vc.view.addSubview(self)
        
        ///开始动画
        showCurrentView()
        ///显示按钮的动画
        showButtons()
    }
    
    
    //MARK:监听方法
    @objc private func clickButton(seletedButton:WBComposeTypeButton) {
        
        //1. 判断当前显示的视图
        let page : Int = Int(scrollView.contentOffset.x/scrollView.bounds.width)
        
        let v = scrollView.subviews[page]
        
        //2. 遍历当前视图
        //选中的按钮放大
        for (i,btn) in v.subviews.enumerated() {
            let anim :POPBasicAnimation = POPBasicAnimation(propertyNamed: kPOPViewScaleXY)
            
            //x,y 在系统中使用CGPoint表示，如果要转换成id 需要使用 ‘NSValue’包装
            //选中按钮变大两倍 未选中的缩小
            let scale = (seletedButton == btn) ? 2 : 0.2
            let value  = NSValue(cgPoint: CGPoint(x: scale, y: scale))
            anim.toValue = value
            anim.duration = 0.5
            btn.pop_add(anim, forKey: nil)
            
            //渐变动画 动画组
                //透明度降低
            let alphaAnim : POPBasicAnimation = POPBasicAnimation(propertyNamed: kPOPViewAlpha)
            
            alphaAnim.toValue = 0.2
            alphaAnim.duration = 0.5
            
            btn.pop_add(alphaAnim, forKey: nil)
            
            //动画监听 完成回调
            if i == 0 {
                anim.completionBlock = { _,_ in
                    self.completionBlock?(seletedButton.clsName)
                }
            }
            
        }
    }
    
    @IBAction func close() {
        //removeFromSuperview()
        hideButtons()
    }
    ///点击更多按钮 翻页
    @objc private func clickMore(){
        print(#function)
        //将scrollView滚动到第二页
        scrollView.setContentOffset(CGPoint(x: scrollView.bounds.width, y: 0), animated: true)
        
        //处理底部按钮 让两个按钮分开
        returnButton.isHidden = false
        let margin = scrollView.bounds.width/6
        closeButtonCenterX.constant += margin
        returnButtonCenterX.constant -= margin
        UIView.animate(withDuration: 0.25) {
            self.layoutIfNeeded()
        }
        
    }
    
    @IBAction func clickReturn() {
        
        //将scrollview滚动到第一页
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        
        closeButtonCenterX.constant = 0
        returnButtonCenterX.constant = 0
        
        //动画完成后再隐藏按钮
        UIView.animate(withDuration: 0.25, animations: {
            self.layoutIfNeeded()
            //渐隐
            self.returnButton.alpha = 0
        }) { (_) in
            self.returnButton.isHidden = true
            self.returnButton.alpha = 1
        }
    }
}

///MARK: - 动画方法
private extension WBComposeTypeView {
    
    //MARK: - 显示动画
    ///动画显示当前视图
    func showCurrentView() {
        
        //1> 创建动画
        
        let anim : POPBasicAnimation = POPBasicAnimation(propertyNamed: kPOPViewAlpha)
        //透明度从0到1
        anim.fromValue = 0
        anim.toValue = 1
        anim.duration = 0.2 //时间
        
        //2> 添加到t视图
        pop_add(anim, forKey: nil)
  
    }
    ///弹力显示所有按钮
    func showButtons() {
        
        //获取 scrollview的子视图的第 0 个视图
        let v = scrollView.subviews[0]
        
        //2.  遍历v中的所有按钮
        for (i,btn) in v.subviews.enumerated() {
            
            //1> 创建动画
            let anim : POPSpringAnimation = POPSpringAnimation(propertyNamed: kPOPLayerPositionY)
            
            //2> 设置动画属性
            anim.fromValue = btn.center.y + 400
            anim.toValue = btn.center.y
            //弹力系数 0-20
            anim.springBounciness = 8
            //弹力速度 0-20
            anim.springSpeed = 8
            
            //设置动画启动时间
            anim.beginTime = CACurrentMediaTime() + CFTimeInterval(i) * 0.025
            
            //3.添加动画
            btn.pop_add(anim, forKey: nil)
        }
    }
    
    //MARK: - 消除动画
    private func hideButtons() {
        //1. 根据contenoffe判断当前显示的子视图
        let page = Int(scrollView.contentOffset.x/scrollView.bounds.width)
        let v = scrollView.subviews[page]
        
        //2. 遍历b 反序
        for (i,btn) in v.subviews.enumerated().reversed() {
            let anim : POPSpringAnimation = POPSpringAnimation(propertyNamed: kPOPLayerPositionY)
            
            //2> 设置动画属性
            anim.fromValue = btn.center.y
            anim.toValue = btn.center.y + 400
            
            //设置时间
            anim.beginTime = CACurrentMediaTime() + CFTimeInterval(v.subviews.count - i) * 0.025
            
            //btn.popd
            btn.layer.pop_add(anim, forKey: nil)
            //监听第0个按钮 最后执行的动画
            if i == 0 {
                anim.completionBlock = {(_,_) -> () in
                    self.hideCurrentView()
                }
            }
        }
    }
    
    func hideCurrentView() {
        let anim : POPBasicAnimation = POPBasicAnimation(propertyNamed: kPOPViewAlpha)
        anim.fromValue = 1
        anim.toValue = 0
        anim.duration = 0.25
        
        pop_add(anim, forKey: nil)
        //添加完成监听方法
        anim.completionBlock = { _,_ in
            self.removeFromSuperview()
        }
    }
    
}


private extension WBComposeTypeView {
    func setupUI() {
        
        //0. 强行更新布局
        layoutIfNeeded()
        
        //1. 向scrollView添加视图
        let rect = scrollView.bounds
        let width = scrollView.bounds.width
        for i in 0..<2 {
            let v = UIView(frame: rect.offsetBy(dx: CGFloat(i) * width, dy: 0))
            //2. 向视图添加按钮
            addButtons(v: v, index: i * 6)
            //3. 将视图添加到scrollView
            scrollView.addSubview(v)
        }
        
        //4设置scrollview
        scrollView.contentSize = CGSize(width: 2 * width, height: 0)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        //禁用滚动
        scrollView.isScrollEnabled = false
    
    }
    /// 向v 中添加按钮，索引从index开始
    /// - Parameters:
    ///   - v:
    ///   - index:开始位置
    func addButtons(v:UIView,index:Int){
        let count = 6
        
        for i in index...(index + count - 1) {
            
            if i >= buttonInfo.count {
                break
            }
            let dict = buttonInfo[i]
            guard let imageName = dict["imageName"],
                let title = dict["title"] else {
                    continue
            }
            
            let btn = WBComposeTypeButton.composeTypeButton(imageName: imageName, title: title)
            
            v.addSubview(btn)
            
            //3.添加监听方法
            if let action = dict["action"] {
                btn.addTarget(self, action: Selector(action), for: .touchUpInside)
            }else {
                
                btn.addTarget(self, action: #selector(clickButton), for: .touchUpInside)
            }
            //4？ 设置要展现的类名
            btn.clsName = dict["clsName"]
            
        }
        
        //按钮布局
        
        //准备常量
        let btnSize = CGSize(width: 100, height: 100)
        let margin = (v.bounds.width - 3 * btnSize.width)/4
        for (i,btn) in v.subviews.enumerated() {
            let y :CGFloat = (i > 2) ? (v.bounds.height - btnSize.height) : 0
            let col = i % 3
            let x = CGFloat(col+1) * margin + CGFloat(col) * btnSize.width
            
            btn.frame = CGRect(x: x, y: y, width: btnSize.width, height: btnSize.height)
        }
    }
}
