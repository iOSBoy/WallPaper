//
//  WPPinItem.swift
//  WallPaper
//
//  Created by yutao on 15-4-27.
//  Copyright (c) 2015年 yutao. All rights reserved.
//

import Foundation

class WPPinItem: NSObject {
    var pinItemKey :NSString!
    var pinItemID  :NSString!
    
    init(pinKey:NSString,pinID :NSString) {
        super.init();
        self.pinItemKey = pinKey;
        self.pinItemID = pinID
    }
    
    func description()->NSString
    {
        return "pinKey:\(pinItemID) || pinItemID:\(pinItemKey)"
    }
}