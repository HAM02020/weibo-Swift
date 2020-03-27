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
    
}

//MARK: - 设置界面
extension WBVisitorView {
    
    
    
    func setupUI(){
        backgroundColor = UIColor.white
        
        setupLabel(withText: "测试label", fontSize: 14, color: UIColor.gray)
        self.addSubview(lab_tip)
        
        setupButton()
        
        
    }
    
    
    ///设置label
    func setupLabel(withText: String,fontSize: CGFloat,color:UIColor){
        lab_tip.frame = CGRect(x: 0, y: 0, width: 100, height: 44)
        lab_tip.center = self.center
        lab_tip.text = withText
        lab_tip.textColor = color
        lab_tip.font = UIFont.systemFont(ofSize: fontSize)
    }
    
    ///设置按钮
    func setupButton(){
        btn_register = textButton(fontSize: 16, normalColor: UIColor.orange, highlighetdColor: UIColor.black
        , backgroundImageName: "common_button_white_disable")
        btn_register?.setTitle("注册", for: .normal)
        btn_register?.frame = CGRect(x: 0, y: 0, width: 64, height: 44)
        
        btn_register?.center = self.center
        self.addSubview(btn_register!)
        
        //登陆按钮
        
        btn_login = textButton(fontSize: 16, normalColor: UIColor.darkGray, highlighetdColor: UIColor.black
        , backgroundImageName: "common_button_white_disable")
        btn_login?.setTitle("登陆", for: .normal)
        btn_login?.frame = CGRect(x: 300, y: 300, width: 64, height: 44)
        
        
        self.addSubview(btn_login!)
    }
    
    func textButton(fontSize:CGFloat,normalColor:UIColor,highlighetdColor:UIColor,backgroundImageName:String) -> UIButton {
        let btn = UIButton()
        btn.titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        btn.setTitleColor(normalColor, for: .normal)
        btn.setTitleColor(highlighetdColor, for: .highlighted)
        btn.setBackgroundImage(UIImage(named: backgroundImageName), for: .normal)
        
        return btn
    }
    
}
