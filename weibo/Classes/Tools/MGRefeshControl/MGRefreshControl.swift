//
//  MGRefreshControl.swift
//  weibo
//
//  Created by 郝心如 on 2020/4/2.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit

///刷新状态切换的临界点
private let MGRefreshOffset :CGFloat = 100
/// 刷新状态
enum MGRefreshState {
    case Normal//普通状态
    case Pulling//超过零界点
    case WillRefresh//超过零界点并且放手
}

class MGRefreshControl: UIControl {
    
    //tableview 和 UICollentionview 的父类
    private weak var scrollView : UIScrollView?
    
    private lazy var refreshView = MGRefreshView.refreshView()
    
    
    
    //这个是存代码的
    init() {
        super.init(frame: CGRect())
        setupUI()
    }
    
    //这个是storyboard的
    required init?(coder: NSCoder) {
        super.init(coder: coder )
        
        setupUI()
    }
    
    ///开始刷新
    func beginRefreshing() {
        print("开始刷新")
    }
    ///结束刷新
    func endRefreshing() {
        print("结束刷新")
    }

    /*
     addSubview 会调用
     - 当添加到父视图的时候是父视图
     - 当父视图被移除的时候是nil
     */
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        
        //  判断父视图的类型
        guard let sv = newSuperview as? UIScrollView else {
            return
        }
        scrollView = sv
        
        // KVO监听父视图的 contenOffset
        scrollView?.addObserver(self, forKeyPath: "contentOffset", options: [], context: nil)
    }
    
    //所有KVO方法都会统一调用方法
    //观察者模式，在不需要的时候都要释放
    // -通知中心 如果不释放 什么也不会发生，但是会有内存泄漏 有多次注册的的可能
    //- KVO 如果不释放 会崩溃！
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        //print(scrollView?.contentOffset)
        
        guard let sv = scrollView else {
            return
        }
        
        //初始高度 应该是 0 越f往下拉越小 所以要取反
        let height = -(sv.contentInset.top + sv.contentOffset.y)
        
        if height < 0 {
            return
        }
        //可以根据高度设置刷新控件的frame
        self.frame = CGRect(x: 0, y: -height, width: sv.bounds.width, height: height)
        
        //判断零界点
        if sv.isDragging {
            if height > MGRefreshOffset && refreshView.refreshState == .Normal {
                print("放手刷新")
                refreshView.refreshState = .Pulling
            }else if height < MGRefreshOffset && refreshView.refreshState == .Pulling {
                print("继续使劲。。。")
                refreshView.refreshState = .Normal
            }
        }else {
            //放手 - 是否超过零界点
            if refreshView.refreshState == .Pulling {
                print("准备开始刷新")
                refreshView.refreshState = .WillRefresh
                
                //让整个刷新视图 显示出来 不缩进去
                //解决方法：修改表格的contenInset
                var inset = sv.contentInset
                inset.top += MGRefreshOffset
                sv.contentInset = inset
                
            }
            
        }
    }
    
    override func removeFromSuperview() {
        //移除kvo
        superview?.removeObserver(self, forKeyPath: "contentOffset")
        
        super.removeFromSuperview()
    }
    
}

extension MGRefreshControl {
    
    func setupUI() {
        backgroundColor = superview?.backgroundColor
        //超出边界不显示
        //clipsToBounds = true
        
        //添加刷新视图
        addSubview(refreshView)
        
        //自动布局
        refreshView.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraint(NSLayoutConstraint(item: refreshView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: refreshView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: refreshView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: refreshView.bounds.width))
        addConstraint(NSLayoutConstraint(item: refreshView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: refreshView.bounds.height))
    }
}
