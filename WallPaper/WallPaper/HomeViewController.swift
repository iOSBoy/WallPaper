//
//  HomeViewController.swift
//  WallPaper
//
//  Created by yutao on 15-4-27.
//  Copyright (c) 2015年 yutao. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController{

    var imageWallCollectionView:UICollectionView?
    var imageTagItemsTableView:UITableView?
    var imageTagItems:NSArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        initNotifications();
        
        imageTagItemsTableView = UITableView(frame: self.view.bounds, style:UITableViewStyle.Plain);
        imageTagItemsTableView?.dataSource = self;
        imageTagItemsTableView?.delegate = self;
        self.view.addSubview(imageTagItemsTableView!);
        
        
        var netWorkManager = WPNetWorkManager();
        
        netWorkManager.WPTagsFormNetWork();
        
//        netWorkManager.WPPinsFormNetWorkWith("美女", limit: 20);
        
    }

    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func initNotifications(){
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "tagItemsSuccessFromNetNotification:", name: WPTagItemsFromNetSuccessNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "tagItemsSuccessFromNetNotification:", name: WPTagItemsFromNetSuccessNotification, object: nil);
        
    }
    
    
    func tagItemsSuccessFromNetNotification(notificaion:NSNotification){
        if let tagArray = notificaion.object as? NSArray{
            
            imageTagItems = tagArray;
            imageTagItemsTableView?.reloadData()
        }
    }
    
    func tagItemsErrorFromNetNotification(notificaion:NSNotification){
        if let errorObject = notificaion.object as? NSError{
            println(errorObject.localizedDescription);
        }
    }
        
    
}


extension HomeViewController:UITableViewDelegate{
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
}

extension HomeViewController:UITableViewDataSource{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tagItemsData = imageTagItems{
            return tagItemsData.count;
        }else{
            return 0;
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = "cellID";
        var cell:UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(identifier) as? UITableViewCell;
        if (cell == nil){
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: identifier);
        }
        if let tagItem:WPTagItem = imageTagItems?.objectAtIndex(indexPath.row) as? WPTagItem{
            cell?.textLabel?.text = tagItem.tagName;
        }
        
        return cell!;
    }

}

