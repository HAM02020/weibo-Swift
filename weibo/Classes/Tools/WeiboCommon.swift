//
//  WeiboCommon.swift
//  weibo
//
//  Created by 郝心如 on 2020/3/29.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import Foundation

////MARK - 应用程序信息
//let WBAppKey = "3371648213"
//let WBAPPSecret = "28f74db958f047fdbca5e6846357f3c0"
//let WBRedirectURI = "http://baidu.com/"

////A01
//let WBAppKey = "4276674222"
//let WBAPPSecret = "610f8119d39ea76957b5fc665d59eb56"
//let WBRedirectURI = "http://127.0.0.1:8080/oauth/callback"

//电竞馆牛顿
let WBAppKey = "32755502"
let WBAPPSecret = "b2be28311bf46112121e28319edd82b1"
let WBRedirectURI = "http://baidu.com/"

//MARK: - 照片浏览通知定义
/// selectedIndex   选中照片的索引
/// urls                    浏览照片的URL字符串数组
/// parentImageViews 父视图的图像视图数组，用户展现和解除转场动画参照
let WBStatusCellBrowserPhotoNotification = "WBStatusCellBrowserPhotoNotification"

let WBStatusCellBrowserPhotoUrlsKey = "WBStatusCellBrowserPhotoUrlsKey"

let WBStatusCellBrowserSelectedIndexKey = "WBStatusCellBrowserSelectedIndexKey"

let WBStatusCellBrowserPhotoImageViewsKey = "WBStatusCellBrowserPhotoImageViewsKey"

//MARK: 全局通知定义

let WBUserShouldLoginNotification = "WBUserShouldLoginNotification"

//用户登陆成功通知
let WBUserLoginSuccessNotification = "WBUserLoginSuccessNotification"


