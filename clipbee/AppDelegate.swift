//
//  AppDelegate.swift
//  clipbee
//
//  Created by nacika on 2014/06/14.
//  Copyright (c) 2014年 nacika. All rights reserved.
//

import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {
                            
    @IBOutlet var window: NSWindow
    @IBOutlet var clipHistoryTable : NSTableView


    /// 起動が完了した
    //-------------------------------------------------------------------------------
    func applicationDidFinishLaunching(aNotification: NSNotification?) {
        // Insert code here to initialize your application
        println("起動が完了しました")
        
 
        
    }

    /// アプリケーションが終了した
    //-------------------------------------------------------------------------------
    func applicationWillTerminate(aNotification: NSNotification?) {
        // Insert code here to tear down your application
    }


}

