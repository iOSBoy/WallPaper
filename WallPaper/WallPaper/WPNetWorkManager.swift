//
//  WPNetWorkManager.swift
//  WallPaper
//
//  Created by yutao on 15-4-27.
//  Copyright (c) 2015年 yutao. All rights reserved.
//

extension NSURLSessionTask{
    func start(){
        self.resume();
    }
}


import Foundation

class WPNetWorkManager: NSObject,NSURLSessionDelegate,NSURLSessionDataDelegate {
    
    var session:NSURLSession!
    var mutableData:NSMutableData = NSMutableData();
    

    override init(){
        super.init();
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration();
        
//        session = NSURLSession(configuration: configuration, delegate: self, delegateQueue: nil);
        session = NSURLSession.sharedSession();
        
    }
    
    
/**********************************************************************************************/
    
    func WPTagsNetSuccessHanderWith(data :NSData){
        var error: NSError?
        let jsonObject:AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &error);
        if let jsonArrayObject = jsonObject as? NSArray{
            var tagArray = NSMutableArray();
            for tagIndex in 0...jsonArrayObject.count - 1{
                if let tagName:NSString = (jsonArrayObject[tagIndex] as? NSDictionary)? ["tag_name"] as? NSString{
                    var tagItem = WPTagItem(name: tagName);
                    tagArray.addObject(tagItem);
                }
            }
        }
    }
    
    
    func WPTagsNetErrorHanderWith(error :NSError){
        println(error.localizedDescription)
    }
    
    
    func WPTagsFormNetWork(){
        var url =  NSURL(string: URL_TAGS);
        let sessionTask =  session.dataTaskWithURL(url!, completionHandler: {
            (data, response, error) -> Void in
            if error != nil {
                self.WPTagsNetErrorHanderWith(error);
            }else{
                self.WPTagsNetSuccessHanderWith(data);
            }
            
        })
        
        sessionTask.start();
        
    }

    
    
    
/**********************************************************************************************/
    
    
    func WPPinsNetErrorHanderWith(error:NSError){
        println(error.localizedDescription)
    }
    
    
    func WPPinsNetSuccessHanderWith(data:NSData){
        var error: NSError?
        let jsonObject:AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &error);
        if let jsonArrayObject = (jsonObject as? NSDictionary)?["pins"] as? NSArray{
            var pinArray = NSMutableArray();
            for pinIndex in 0...jsonArrayObject.count - 1{
                let pin_id = (jsonArrayObject[pinIndex] as? NSDictionary)?["pin_id"] as? Int;
                let pin_key = (((jsonArrayObject[pinIndex] as? NSDictionary)?["file"]) as? NSDictionary)?["key"] as? NSString;
                var pinItem = WPPinItem(pinKey: pin_key!, pinID: String(pin_id!));
                
                pinArray.addObject(pinItem);
            }
        }
        
    }
    
    func WPPinsFormNetWorkWith(tag :String,limit : Int){
        var urlString = URL_PINS + "?tag=\(tag)&limit=\(limit)".stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!;
        var url =  NSURL(string: urlString);
        let sessionTask =  session.dataTaskWithURL(url!, completionHandler: { (data, response, error) -> Void in
            if error != nil {
                self.WPPinsNetErrorHanderWith(error);
            }else{
                self.WPPinsNetSuccessHanderWith(data);
            }
        });
        sessionTask.start();
        
    }
}