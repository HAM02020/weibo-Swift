//
//  WBComposeViewController.swift
//  weibo
//
//  Created by 郝心如 on 2020/4/4.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit

///撰写微博控制器
class WBComposeViewController: UIViewController {
    //文本编辑视图
    @IBOutlet weak var textView: UITextView!
    //底部工具栏
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet var sendButton: UIButton!
    @IBOutlet var titleLabel: UILabel!
    
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
        
    }
    @objc private func close(){
        dismiss(animated: true, completion: nil)
    }

   //MARK: - 按钮监听方法
    
    ///发布微博
    @IBAction func postStatus() {
        print("发布微博")
    }
    

}

private extension WBComposeViewController {
    func setupUI() {
        
        view.backgroundColor = UIColor.white
        setupNavigationBar()
        setupToolbar()
    }
    ///设置工具栏
    func setupToolbar() {
        let itemSettings = [["imageName":"compose_pic"],
                            ["imageName":"compose_smile"],
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
