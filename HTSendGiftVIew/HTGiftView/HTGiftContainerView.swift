//
//  HTGiftContainerView.swift
//  HTSendGiftVIew
//
//  Created by 魏小庄 on 2017/11/13.
//  Copyright © 2017年 魏小庄. All rights reserved.
//

import UIKit

private let kChannelCount = 2
private let kChannelH  : CGFloat = 50
private let kChannelMargin : CGFloat = 10

class HTGiftContainerView: UIView {

    // MARK: 定义属性
    fileprivate lazy var channelViews : [HTGiftChannelView] = [HTGiftChannelView]()
    fileprivate lazy var cacheGiftModels : [HTGiftModel] = [HTGiftModel]()
    
    // MARK: 构造函数
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension HTGiftContainerView{
    
   fileprivate func setUpUI() {
    
    let channelX : CGFloat = 0
    let channelW : CGFloat = frame.width
    let channelH : CGFloat = kChannelH
    
    // 根据当前设置的渠道数，设置
    for i in 0..<kChannelCount {
        
        let channelY : CGFloat = (kChannelMargin + channelH) * CGFloat(i)
        
        let channelView = HTGiftChannelView.loadForXib()
        channelView.frame = CGRect(x: channelX, y: channelY, width: channelW, height: channelH)
        channelView.alpha = 0.0
        addSubview(channelView)
        // 添加到数组
        channelViews.append(channelView)
        // 执行完毕的回调， 在回调里，重新赋值模型，发起礼物
        channelView.complectionCallBack = { channelView in
            // 如果没有剩余的礼物直接返回
            guard self.cacheGiftModels.count != 0 else{
                return;
            }
            // 取出缓存的礼物模型
            let firstGiftModel = self.cacheGiftModels.first!
            self.cacheGiftModels.removeFirst()
            // 让闲置的channelVIew 执行动画
            channelView.giftModel = firstGiftModel
            
            // 将数组中相同的礼物模型，加入到channelView缓存中
            for i in (0..<self.cacheGiftModels.count).reversed(){
                let giftModel = self.cacheGiftModels[i]
                if giftModel .isEqual(firstGiftModel){
                   channelView.addOnceToCache()
                    self.cacheGiftModels.remove(at: i)
                }
                
            }
        }
        
    }
    }
    
    
}

extension HTGiftContainerView{
    // 发送礼物 传递礼物模型进行展示
    func showGiftModel(_ sendModel : HTGiftModel) {
        // 判断channelView
        if let channleView = checkUsingChannelVew(sendModel) {
              // 直接添加
            channleView.addOnceToCache()
            return
        }
        
        // 判断是否有闲置的ChannelView
        if let channelView = checkIdleChannelView(){
            channelView.giftModel = sendModel
            return
        }
        // 如果没有闲置的并且 发送者和发送的模型不同，先保存起来
        cacheGiftModels.append(sendModel)
        
    }
    
    private func checkUsingChannelVew(_ giftModel : HTGiftModel) -> HTGiftChannelView?{
        for channelView  in channelViews{
            // 如果 当前发送的和上一个同一个模型，并且和 上一个礼物还没有显示完毕 直接叠加
            if giftModel.isEqual(channelView.giftModel) && channelView.state != .endAnimating{
                return channelView
            }
        }
        return nil
    }
    
    private func checkIdleChannelView() -> HTGiftChannelView?{
        for channelView in channelViews{
            if channelView.state == .idle{
                return channelView
            }
        }
        return nil
    }
    
}


