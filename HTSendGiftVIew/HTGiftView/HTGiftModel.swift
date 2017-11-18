//
//  HTGiftModel.swift
//  HTSendGiftVIew
//
//  Created by 魏小庄 on 2017/11/13.
//  Copyright © 2017年 魏小庄. All rights reserved.
//

import UIKit

class HTGiftModel: NSObject {

    var sendName : String = ""
    var sendUrl : String = ""
    var giftName : String = ""
    var giftUrl : String = ""
    
    // 重新init方法
    init(sendName : String, sendUrl : String, giftName : String, giftUrl : String ) {
        self.sendName = sendName
        self.sendUrl = sendUrl
        self.giftUrl = giftUrl
        self.giftName = giftName
    }
    // 重新系统IsEqual 方法，判断模型是否一致
    override func isEqual(_ object: Any?) -> Bool {
        // 校验类型
        guard let obj = object as? HTGiftModel else {
            return false
        }
        // 如果 送礼物者是同一个人送的同一个礼物
        guard obj.giftName == giftName && obj.sendName == sendName else {
            return false
        }
        return true
    }
    
}
