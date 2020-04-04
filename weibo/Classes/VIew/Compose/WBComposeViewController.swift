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

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.orange
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "退出", target: self, action: #selector(Stream.close))
        
    }
    @objc private func close(){
        dismiss(animated: true, completion: nil)
    }

   

}
