//
//  WBStatusCell.swift
//  weibo
//
//  Created by 郝心如 on 2020/3/31.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit

class WBStatusCell: UITableViewCell {

    ///头像
    @IBOutlet weak var iconView: UIImageView!
    ///姓名
    @IBOutlet weak var nameLabel: UILabel!
    ///皇冠图标
    @IBOutlet weak var memberIconView: UIImageView!
    ///时间
    @IBOutlet weak var timeLabel: UILabel!
    ///来源
    @IBOutlet weak var sourceLabel: UILabel!
    ///认证图标
    @IBOutlet weak var vipIcon: UIImageView!
    ///微博正文
    @IBOutlet weak var statusLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
