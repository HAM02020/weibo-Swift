//
//  MGLabel.swift
//  weibo
//
//  Created by 郝心如 on 2020/4/5.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit



class MGLabel: UILabel {

    //MARK: - 重写属性
    override var text: String? {
        didSet {
            prepareTextContent()
        }
    }
    override var attributedText: NSAttributedString?{
        didSet {
            prepareTextContent()
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        prepareTextSystem()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        prepareTextSystem()
    }
    //MARK: 交互
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        //获取点击的位置
        guard let location = touches.first?.location(in: self) else {
            return
        }
        
        //2. 获取当前点中字符的索引
        let idx = layoutManager.glyphIndex(for: location, in: textContainer)
        
        //3.判断idx是否在urls的 ranges内 ，如果在就高亮
        
        for r in urlRanges ?? [] {
            if NSLocationInRange(idx, r ) {
                print("需要高亮")
                
                //修改文本的字体属性
                textStorage.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.blue], range: r)
                
                //如果需要重新绘图 y需要调用
                setNeedsDisplay()
            }else {
                print("没按到url")
            }
        }
        
        
        print("点我了")
        
        
    }
    
    
    ///绘制文本
    override func drawText(in rect: CGRect) {
        
        let range = NSRange(location: 0, length: textStorage.length)
        
        //绘制背景
        layoutManager.drawBackground(forGlyphRange: range, at: CGPoint())
        
        //绘制 Glyphs字形
        layoutManager.drawGlyphs(forGlyphRange: range, at: CGPoint())
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //指定绘制文本的区域
        textContainer.size = bounds.size
    }
    
    ///属性文本储存
    private lazy var textStorage = NSTextStorage()
    ///负责文本‘字形’  布局
    private lazy var layoutManager = NSLayoutManager()
    ///设定文本绘制的范围
    private lazy var textContainer = NSTextContainer()
    
    
    
}

extension MGLabel {
    func prepareTextSystem() {
        //1. 准备文本内容
        prepareTextContent()
        
        //2.设置对象的关系
        textStorage.addLayoutManager(layoutManager)
        layoutManager.addTextContainer(textContainer)
        
        
        
    }
    
    func prepareTextContent() {
        
        //0. 开启用户交互
        isUserInteractionEnabled = true
        
        //textStorage接管 label
        if let attributedText = attributedText {
            textStorage.setAttributedString(attributedText)
        }else if let text = text {
            textStorage.setAttributedString(NSAttributedString(string: text))
        }else {
            textStorage.setAttributedString(NSAttributedString(string: ""))
        }
        
        //遍历范围数组，设置url文字的属性
        for r in urlRanges ?? [] {
            textStorage.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.blue], range: r)
        }
    }
}

//MARK: - 正则表达式函数
private extension MGLabel {
    var urlRanges : [NSRange]? {
        
        var ranges = [NSRange]()
        //1.正则表达式
        let patterns = ["[\\w]*://[\\w/\\.]*","#.*?#","@[\\u4e00-\\u9fa5a\\w\\-]*"]
        for pattern in patterns {
            guard let regx = try? NSRegularExpression(pattern: pattern, options: []) else {
                return nil
            }
            
            // 匹配多个
            let matches = regx.matches(in: textStorage.string, options: [], range: NSRange(location: 0, length: textStorage.length))

            for m in matches {
                ranges.append(m.range(at: 0))
            }
        }
        
        
        return ranges
    }
}
