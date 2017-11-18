//
//  ViewController.swift
//  HTSendGiftVIew
//
//  Created by 魏小庄 on 2017/11/13.
//  Copyright © 2017年 魏小庄. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    fileprivate lazy var giftContainerView : HTGiftContainerView = HTGiftContainerView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        // 设置frame
        giftContainerView.frame = CGRect(x: 0, y: 150, width: 320, height: 120);
        giftContainerView.backgroundColor = .lightGray
        view.addSubview(giftContainerView);
        
    }
    
    //MARK: - methods
    @IBAction func sendGift1(_ sender: Any) {
        let giftModel = HTGiftModel(sendName:"魏小庄哥哥", sendUrl: "3", giftName: "火箭", giftUrl: "share")
        
        giftContainerView.showGiftModel(giftModel)
    
    }

    @IBAction func sendGift2(_ sender: Any) {
        let mode2 = HTGiftModel(sendName: "卢小波", sendUrl: "1", giftName: "大炮", giftUrl: "prompt")
        
        giftContainerView.showGiftModel(mode2)
        
    }
    
    @IBAction func sendGift3(_ sender: Any) {
      
        let model3 = HTGiftModel(sendName: "王二狗子", sendUrl: "6", giftName: "飞机", giftUrl: "Star")
        
        giftContainerView.showGiftModel(model3)
    }
}

