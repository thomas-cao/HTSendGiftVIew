//
//  HTGiftDigitLable.swift
//  HTSendGiftVIew
//
//  Created by 魏小庄 on 2017/11/14.
//  Copyright © 2017年 魏小庄. All rights reserved.
//

import UIKit

class HTGiftDigitLable: UILabel {


    override func drawText(in rect: CGRect) {
        // 获取上下文
        let context = UIGraphicsGetCurrentContext()
        // 给上下文线段设置宽度，通过宽度画出文本
        context?.setLineWidth(5)
        context?.setLineJoin(.round)
        context?.setTextDrawingMode(.stroke)
        textColor = UIColor.red
        super.drawText(in: rect)
        
        context?.setTextDrawingMode(.fill)
        textColor = UIColor.purple
        super.drawText(in: rect)
    }
    
    // 设置动画 动画完毕后回调
    func showDigitAnimation(_ complection : @escaping () -> ()) {
        
        UIView.animateKeyframes(withDuration: 0.25, delay: 0, options: [], animations: {
            // 执行放大的弹性动画
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.5, animations: {
                self.transform = CGAffineTransform(scaleX: 3.5, y: 3.5)
            })
            // 在缩小 ，
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
                self.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
            })
            
        }) { (_) in
            UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 10, options: [], animations: {
                self.transform = CGAffineTransform.identity
            }, completion: { (_) in
                complection()
            })
            
        }
        
    }
    
    
}
