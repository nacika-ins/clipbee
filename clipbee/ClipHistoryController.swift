//
//  ClipHistoryController.swift
//  clipbee
//
//  Created by nacika on 2014/06/14.
//  Copyright (c) 2014年 nacika. All rights reserved.
//

import Cocoa
import AppKit

class ClipHistoryController: NSObject, NSTableViewDataSource,NSTableViewDelegate {

    var dataArray = String[]()
    
    func numberOfRowsInTableView(aTableView: NSTableView!) -> Int {
        println("A")
        return 0
    }
    
    
    func tableView(aTableView: NSTableView!,
        objectValueForTableColumn aTableColumn: NSTableColumn!,
        row rowIndex: Int) -> AnyObject!
    {
        println("B")
        return 0
    }
    
    
    

    
    
//    - (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
//    {
//    NSLog(@"%s", __func__);
//    NSDictionary *data = [_dataArray objectAtIndex:row];
//    
//    
//    if ([[tableColumn identifier] isEqualToString:@"TITLE"]) {
//    
//    
//    return [data objectForKey:@"title"];
//    } else {
//    return [data objectForKey:@"description"];
//    }
//    }
    
//    - (NSInteger)numberOfRowsInTableView:(NSTableView*)tableView
//    {
//    NSLog(@"%s", __func__);
//    
//    return _dataArray.count;
//    }

    

}
