//
//  WBStatusToolBar.swift
//  weibo
//
//  Created by 郝心如 on 2020/4/1.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit

class WBStatusToolBar: UIView {

    var viewModel : WBStatusViewModel? {
        didSet{
//            btn_retweeted.setTitle("\(viewModel?.status.reposts_count)", for: [])
//            btn_comment.setTitle("\(viewModel?.status.comments_count)", for: [])
//            btn_like.setTitle("\(viewModel?.status.attitudes_count)", for: [])
            
            btn_retweeted.setTitle(viewModel?.retweedtedStr, for: [])
            btn_comment.setTitle(viewModel?.commentStr, for: [])
            btn_like.setTitle(viewModel?.likeStr, for: [])
        }
    }
    
    ///转发
    @IBOutlet weak var btn_retweeted: UIButton!
    ///评论
    @IBOutlet weak var btn_comment: UIButton!
    ///点赞
    @IBOutlet weak var btn_like: UIButton!
    
    
    
}
