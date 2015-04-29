//
//  WPTagItem.swift
//  WallPaper
//
//  Created by yutao on 15-4-27.
//  Copyright (c) 2015年 yutao. All rights reserved.
//

import Foundation

class WPTagItem: NSObject {
    var tagName : String!
    
    init(name:String) {
        super.init();
        self.tagName = name;
    }
    
    func description()->NSString{
        return "tagName :\(tagName)"
    }
}