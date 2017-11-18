//
//  HTGiftChannelView.swift
//  HTSendGiftVIew
//
//  Created by 魏小庄 on 2017/11/13.
//  Copyright © 2017年 魏小庄. All rights reserved.
//

import UIKit

enum HTGiftChannelState{
    case idle
    case animating
    case willEnd
    case endAnimating
}

class HTGiftChannelView: UIView {

    @IBOutlet weak var sendIcon: UIImageView!
    @IBOutlet weak var giftIcon: UIImageView!
    @IBOutlet weak var giftDesc: UILabel!
    @IBOutlet weak var sendName: UILabel!
    
    @IBOutlet weak var digitLable: HTGiftDigitLable!
    
    fileprivate var currentNumber : Int = 0
    fileprivate var cacheNumber : Int = 0
    
    // 一个ChannelView动画执行完毕的回调
    var complectionCallBack : ((HTGiftChannelView) -> Void)?
    
    var state : HTGiftChannelState = .idle
    
    var giftModel : HTGiftModel?{
        didSet{
            // 对模型进行校验
            guard let giftModel = giftModel else {
                return
            }
            // 对UI赋值
            sendIcon.image = UIImage(named: giftModel.sendUrl)
            sendName.text = giftModel.sendName
            giftDesc.text = "送出礼物：【\(giftModel.giftName)】"
            giftIcon.image = UIImage(named: giftModel.giftUrl)

             // 设置channelView状态 ，将view弹出
            state = .animating
            // 开始执行弹出动画
            performAnimation()
        }
    }
}

extension HTGiftChannelView{
    func addOnceToCache(){
        // 如果是还没有结束上一个ChannelView的显示 直接叠加
        if self.state == .willEnd {
            // 执行叠加数量动画
            preformDigitAnimation()
            NSObject.cancelPreviousPerformRequests(withTarget: self)
            
        }else{
            // 没有闲置的channelView 保存礼物数
            cacheNumber += 1
        }
        
    }
    
    
    // 便利加载构造方法
    class func  loadForXib() -> HTGiftChannelView {
        
        return  Bundle.main.loadNibNamed("HTGiftChannelView", owner: nil, options: nil)?.first as! HTGiftChannelView
    }
    
    
}
// MARK: - 执行动画
extension HTGiftChannelView{
    
    fileprivate func performAnimation(){
        // 显示个数lable
        digitLable.alpha = 1.0
        digitLable.text = " x1 "
        UIView.animate(withDuration: 0.25, animations: {
            self.alpha = 1.0
            self.frame.origin.x = 0
        }) { (_) in
           // 出现后设置，礼物个数的动画
            self.preformDigitAnimation()
        }
        
    }
    
    fileprivate func preformDigitAnimation(){
        // 叠加数量
        currentNumber += 1
        digitLable.text = " x\(currentNumber)"
        digitLable.showDigitAnimation {
            // 判断是否还需要叠加当前礼物
            if self.cacheNumber > 0{
                self.cacheNumber -= 1
                self.preformDigitAnimation()
            }else{
                self.state = .willEnd
                // 停留3.0秒后，消失。
                self.perform(#selector(self.performEndAnimation), with: nil, afterDelay: 1.0)
            }
        }
        
    }

    @objc fileprivate func performEndAnimation() {
        // 重置状态
        state = .endAnimating
        UIView.animate(withDuration: 0.25, animations: {
            self.frame.origin.x = UIScreen.main.bounds.width
            self.alpha = 0.0
        }) { (_) in
            // 重置
            self.currentNumber = 0
            self.cacheNumber = 0
            self.giftModel = nil
            self.frame.origin.x = -self.frame.width
            self.state = .idle
            // 回调
            if let complectionCallBack = self.complectionCallBack{
                complectionCallBack(self)
            }
        }
        
    }
    
}


