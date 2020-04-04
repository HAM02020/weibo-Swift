//
//  WBStatusCell.swift
//  weibo
//
//  Created by 郝心如 on 2020/3/31.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit

class WBStatusCell: UITableViewCell {

    var viewModel : WBStatusViewModel? {
        didSet {
            
            //设置微博文本
            statusLabel.text = viewModel?.status.text
            //被转发微博的正文
            retweededLabel?.text = viewModel?.retweetedText
            //姓名
            nameLabel.text = viewModel?.status.user?.screen_name
            //会员等级 根据 mbrank的值设置属性
            memberIconView.image = viewModel?.memberIcon
            //认证图标
            vipIcon.image = viewModel?.vipIcon
            //用户头像
            iconView.mg_setImage(urlString: viewModel?.status.user?.profile_image_url, placeholderImage: UIImage(named: "Avatar"),isAvatar: true)
            //底部工具栏
            toolBar.viewModel = viewModel
            
            
            pictureView.viewModel = viewModel
            
//            //测试4张图像
//            if viewModel!.status.pic_urls!.count > 4{
//                //将末尾的删除
//                var picURLs = viewModel!.status.pic_urls!
//                picURLs.removeSubrange((picURLs.startIndex + 4)..<picURLs.endIndex)
//                
//                pictureView.urls = picURLs
//            }else{
//                pictureView.urls = viewModel?.status.pic_urls
//            }
            
            
            //设置配图视图的url数据
            pictureView.urls = viewModel?.picUrls
            
            //设置来源

            sourceLabel.text = viewModel?.status.source
        }
    }
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
    //底部工具栏
    @IBOutlet weak var toolBar: WBStatusToolBar!
    //配图视图
    @IBOutlet weak var pictureView: WBStatusPictureView!
    
    @IBOutlet weak var retweededLabel: UILabel? //注意 这里是 ？ 号 因为原创微博没有这一项
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //异步绘制 离屏渲染
        self.layer.drawsAsynchronously = true
        
        //栅格化
        //必须指定分辨率 不然h很模糊
        self.layer.shouldRasterize = true
        //分辨率
        self.layer.rasterizationScale = UIScreen.main.scale
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}
