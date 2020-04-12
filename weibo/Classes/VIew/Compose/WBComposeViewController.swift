//
//  WBComposeViewController.swift
//  weibo
//
//  Created by 郝心如 on 2020/4/4.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit
import SVProgressHUD
///撰写微博控制器
class WBComposeViewController: UIViewController {
    //文本编辑视图
    @IBOutlet weak var textView: UITextView!
    //底部工具栏
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet var sendButton: UIButton!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet weak var placeHolderLabel: UILabel!
    ///工具栏底部约束
    @IBOutlet weak var tooBarBottomCons: NSLayoutConstraint!
    
    private var keyboardHeight:CGFloat?
    
//    lazy var sendButton : UIButton = {
//        let btn = UIButton()
//        btn.setTitle("发布", for: [])
//        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
//
//        //设置标题颜色
//        btn.setTitleColor(UIColor.white, for: [])
//        btn.setTitleColor(UIColor.gray, for: .disabled)
//        btn.setBackgroundImage(UIImage(named: "compose_button_orange"), for: .normal)
//        btn.setBackgroundImage(UIImage(named: "compose_button_orange_highlighted"), for: .highlighted)
//        btn.setBackgroundImage(UIImage(named: "compose_button_white"), for: .disabled)
//
//        btn.frame = CGRect(x: 0, y: 0, width: 64, height: 44)
//
//        return btn
//    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        
        //监听键盘通知
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardChanged),
                                               name: UIResponder.keyboardWillChangeFrameNotification,
                                               object: nil)
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //激活键盘
        textView.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        //关闭键盘
        textView.resignFirstResponder()
    }
    
    //MARK: - textview监听方法
    @objc func textChanged() {
        print("textChanged")
    }
    
    //MARK: - 键盘监听方法
    @objc private func keyboardChanged(n:Notification){
        //1.目标rect
        guard let rect = (n.userInfo?["UIKeyboardFrameEndUserInfoKey"] as? NSValue)?.cgRectValue,
            let duration = (n.userInfo?["UIKeyboardAnimationDurationUserInfoKey"] as? NSNumber)?.doubleValue
        else {
            return
        }
        if keyboardHeight == nil && rect.height > 0 {
            keyboardHeight = rect.height
        }
        
        
        
        //2. 设置底部约束的高度
        let offset = UIScreen.main.bounds.height - rect.origin.y
        
        //3. 更新底部约束
        tooBarBottomCons.constant = -offset
        
        //4. 动画更新约束
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
    }
    
    
    @objc private func close(){
        dismiss(animated: true, completion: nil)
    }

   //MARK: - 按钮监听方法
    
    ///发布微博
    @IBAction func postStatus() {
        print("发布微博")
        
        //1.  获取微博文字
        guard var text = textView.text else {
            return
        }
        //2. 发布微博
        text += " http://www.baidu.com"
        WBNetworkManager.shared().postStatus(text: text) { (result, isSuccess) in
            
            let message = isSuccess ? "发布成功" : "网络不给力"
            //修改通知样式
            SVProgressHUD.setDefaultStyle(.dark)
            SVProgressHUD.showInfo(withStatus: message)
            //如果成功关闭当前窗口
            if isSuccess {
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1) {
                    //恢复样式
                    SVProgressHUD.setDefaultStyle(.light)
                    self.close()
                }
            }
        }
        
    }
    ///切换表情键盘
    @objc private func emoticonKeyboard() {
        //如果使用系统默认的键盘，输入视图为nil
        let keyboardView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: keyboardHeight ?? 300))
        keyboardView.backgroundColor = UIColor.blue
        
        //2> 设置键盘视图
        textView.inputView = (textView.inputView == nil) ? keyboardView : nil
        
        //3. 刷新键盘视图
        textView.reloadInputViews()
    }
    

}

//MARK: - UITextViewDelegate
extension WBComposeViewController : UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        sendButton.isEnabled = textView.hasText
        placeHolderLabel.isHidden = textView.hasText
    }
    
    
}


private extension WBComposeViewController {
    func setupUI() {
        
        view.backgroundColor = UIColor.white
        setupNavigationBar()
        setupToolbar()
        
        textView.delegate = self
    }
    ///设置工具栏
    func setupToolbar() {
        let itemSettings = [["imageName":"compose_pic"],
                            ["imageName":"compose_smile","actionName":"emoticonKeyboard"],
                            ["imageName":"compose_hashtag"],
                            ["imageName":"compose_email"],
                            ["imageName":"compose_add"]
                                                        ]
        var items = [UIBarButtonItem]()
        for s in itemSettings {
            
            guard let imageName = s["imageName"] else {
                continue
            }
            
            let image = UIImage(named: imageName)
            let image_highlighted = UIImage(named: imageName+"_h")
            
            let btn = UIButton()
            btn.setImage(image, for: [])
            btn.setImage(image_highlighted, for: .highlighted)
            
            //btn.sizeToFit()
            
            //判断actionName
            if let actionName = s["actionName"] {
                //添加监听方法
                btn.addTarget(self, action: Selector(actionName), for: .touchUpInside)
            }
            
            //追加按钮
            items.append(UIBarButtonItem(customView: btn))
            //追加弹簧
            items.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil))
        }
        //删除末尾弹簧
        items.removeLast()
        
        toolBar.items = items
    }
    
    func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", target: self, action: #selector(Stream.close))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: sendButton)
        
        //设置标题视图
        navigationItem.titleView = titleLabel
        
        
        sendButton.isEnabled = false
    }
}
