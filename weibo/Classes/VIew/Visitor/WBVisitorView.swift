//
//  WBVisitorView.swift
//  weibo
//
//  Created by 郝心如 on 2020/3/27.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit

///访客视图

class WBVisitorView: UIView {
    ///图像视图
    private lazy var iconView = UIImageView(image: UIImage(named:"visitordiscover_feed_image_smallicon"))
    
    ///小房子
    private lazy var houseIconView = UIImageView(image: UIImage(named:"visitordiscover_feed_image_house"))
    
    ///提示标签
    private lazy var lab_tip = UILabel()
    
    ///注册按钮
    private var btn_register :UIButton?
    
    ///登陆按钮
    private var btn_login : UIButton?
    
    

    
    override init(frame: CGRect) {
        super.init(frame:frame)
        setupUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    ///使用字典设置访客视图的信息
    ///
    /// - parameter dict:[imageName/messgage]
    func setupInfo(dict:[String:String]) {
        
        //1> 取字典信息
        guard let imageName = dict["imageName"],
        let message = dict["message"] else {
            return
        }
        
        //2> 设置消息
        lab_tip.text = message
        if imageName == "" {
            return
        }
        iconView.image = UIImage(named: imageName)
    }
    
}

//MARK: - 设置界面
extension WBVisitorView {
    
    
    
    func setupUI(){
        backgroundColor = UIColor.white
        
        setupLabel(withText: "关注一些人，回这里看看有什么惊喜，关注一些人，回这里看看有什么惊喜", fontSize: 16, color: UIColor.gray)
        self.addSubview(lab_tip)
        self.addSubview(houseIconView)
        setupButton()
        
        //2. 取消autoResizing 与 自动布局不能共存
        for v in subviews {
            v.translatesAutoresizingMaskIntoConstraints = false
        }
        
        //3. 自动布局
        
        //1> 小房子
        addConstraint(NSLayoutConstraint(item: houseIconView,
                                         attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .centerX,
                                         multiplier: 1.0,
                                         constant: 0))
        addConstraint(NSLayoutConstraint(item: houseIconView,
                                         attribute: .centerY,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .centerY,
                                         multiplier: 1.0,
                                         constant: -100))
        let margin : CGFloat = 20
        //2> 提示标签
        addConstraint(NSLayoutConstraint(item: lab_tip,
                                        attribute: .centerX,
                                        relatedBy: .equal,
                                        toItem: self,
                                        attribute: .centerX,
                                        multiplier: 1.0,
                                        constant: 0))
        addConstraint(NSLayoutConstraint(item: lab_tip,
                                        attribute: .top,
                                        relatedBy: .equal,
                                        toItem: houseIconView,
                                        attribute: .bottom,
                                        multiplier: 1.0,
                                        constant: margin))
        addConstraint(NSLayoutConstraint(item: lab_tip,
                                         attribute: .width,
                                        relatedBy: .equal,
                                        toItem: nil,
                                        attribute: .notAnAttribute,
                                        multiplier: 1.0,
                                        constant: 280))
        
        //4> 注册按钮
        addConstraint(NSLayoutConstraint(item: btn_register as Any,
                                         attribute: .left,
                                         relatedBy: .equal,
                                         toItem: lab_tip,
                                         attribute: .left,
                                         multiplier: 1.0,
                                         constant: 0))
        addConstraint(NSLayoutConstraint(item: btn_register as Any,
                                        attribute: .top,
                                        relatedBy: .equal,
                                        toItem: lab_tip,
                                        attribute: .bottom,
                                        multiplier: 1.0,
                                        constant: margin))
        addConstraint(NSLayoutConstraint(item: btn_register as Any,
                                        attribute: .width,
                                        relatedBy: .equal,
                                        toItem: nil,
                                        attribute: .notAnAttribute,
                                        multiplier: 1.0,
                                        constant: 110))
        
        //4> 登陆按钮
        addConstraint(NSLayoutConstraint(item: btn_login as Any,
                                         attribute: .right,
                                         relatedBy: .equal,
                                         toItem: lab_tip,
                                         attribute: .right,
                                         multiplier: 1.0,
                                         constant: 0))
        addConstraint(NSLayoutConstraint(item: btn_login as Any,
                                        attribute: .top,
                                        relatedBy: .equal,
                                        toItem: lab_tip,
                                        attribute: .bottom,
                                        multiplier: 1.0,
                                        constant: margin))
        addConstraint(NSLayoutConstraint(item: btn_login as Any,
                                        attribute: .width,
                                        relatedBy: .equal,
                                        toItem: nil,
                                        attribute: .notAnAttribute,
                                        multiplier: 1.0,
                                        constant: 110))
        
        
    }
    
    
    ///设置label
    func setupLabel(withText: String,fontSize: CGFloat,color:UIColor){
        lab_tip.frame = CGRect(x: 0, y: 0, width: 100, height: 44)
        lab_tip.text = withText
        lab_tip.textColor = color
        lab_tip.font = UIFont.systemFont(ofSize: fontSize)
        //自动换行
        lab_tip.numberOfLines = 0
    }
    
    ///设置按钮
    func setupButton(){
        btn_register = textButton(fontSize: 16, normalColor: UIColor.orange, highlighetdColor: UIColor.black
        , backgroundImageName: "common_button_white_disable")
        btn_register?.setTitle("注册", for: .normal)
        
        self.addSubview(btn_register!)
        
        //登陆按钮
        
        btn_login = textButton(fontSize: 16, normalColor: UIColor.darkGray, highlighetdColor: UIColor.black
        , backgroundImageName: "common_button_white_disable")
        btn_login?.setTitle("登陆", for: .normal)
        
        
        self.addSubview(btn_login!)
    }
    
    func textButton(fontSize:CGFloat,normalColor:UIColor,highlighetdColor:UIColor,backgroundImageName:String) -> UIButton {
        let btn = UIButton()
        let img = UIImage(named: backgroundImageName)
        btn.frame = CGRect(x: 0, y: 0, width: img?.size.width ?? 128, height:  img?.size.height ?? 64)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        btn.setTitleColor(normalColor, for: .normal)
        btn.setTitleColor(highlighetdColor, for: .highlighted)
        btn.setBackgroundImage(img, for: .normal)
        //设置阴影
        btn.layer.shadowColor = UIColor.darkGray.cgColor
        btn.layer.shadowOffset = CGSize.init(width: 1, height: 1)
        btn.layer.shadowRadius = 5;
        btn.layer.shadowOpacity = 0.2;
        
        
        
        return btn
    }
    
}
