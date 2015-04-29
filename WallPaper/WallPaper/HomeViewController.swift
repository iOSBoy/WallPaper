//
//  HomeViewController.swift
//  WallPaper
//
//  Created by yutao on 15-4-27.
//  Copyright (c) 2015年 yutao. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var netWorkManager = WPNetWorkManager();
        
//        netWorkManager.WPTagsFormNetWork();
        netWorkManager.WPPinsFormNetWorkWith("美女", limit: 20);
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

